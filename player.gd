extends KinematicBody2D

var sprite
var asprite = []
var lfoot
var rfoot
var left
var right
var hspeed = 0
var vspeed = 0
var onGround = false

export (int) var speed = 10
export (int) var jumpSpeed = -400
export (int) var gravity = 1000

var velocity = Vector2()
var speedOnJump = 0

var hurting = false
var hurtloop = 0
var hurtcount = 0

var jumping = true

export var max_speed = 100

func _ready():
	asprite = [get_node("sprite"), get_node("sprite1"), get_node("sprite2"), get_node("sprite3")]
	sprite = get_node("sprite")
	lfoot = get_node("leftFoot")
	rfoot = get_node("rightFoot")
	right = get_node("right")
	left = get_node("left")
	lfoot.add_exception(self)
	lfoot.add_exception(right)
	lfoot.add_exception(left)
	rfoot.add_exception(self)
	rfoot.add_exception(right)
	rfoot.add_exception(left)
	right.add_exception(self)
	right.add_exception(right)
	right.add_exception(left)
	left.add_exception(self)
	left.add_exception(right)
	left.add_exception(left)
	set_fixed_process(true)

func get_input():
	if (!global.talking || !global.stopntalk) && !global.dead:
		var right = Input.is_action_pressed("ui_right")
		var left = Input.is_action_pressed("ui_left")
		var jump = Input.is_action_pressed("ui_up")
		var drop = Input.is_action_pressed("ui_down")
		if onGround:
			if drop and (lfoot.get_collider().is_in_group("locker") || rfoot.get_collider().is_in_group("locker")):
				set_pos(Vector2(get_pos().x, get_pos().y+1))
			if jump && !jumping:
				jumping = true
				velocity.y = jumpSpeed
			elif !jump:
				jumping = false
			if right and velocity.x < max_speed:
				velocity.x += speed
			if left and velocity.x > -max_speed:
				velocity.x -= speed
			if !left && !right:
				velocity.x = 0
		else:
			if right and velocity.x < max_speed:
				velocity.x += speed/1.5
			if left and velocity.x > -max_speed:
				velocity.x -= speed/1.5
	else:
		if onGround:
			velocity.x = 0

func _fixed_process(delta):
	if sprite.get_frame() == 16:
		global.dead = false
		sprite.set_animation("idle")
		_hurt(0)
	
	onGround = lfoot.is_colliding() || rfoot.is_colliding()
	
	get_input()
	
	velocity.y += gravity * delta
	var motion = velocity*delta
	
	if !onGround:
		motion.x = motion.x * 1.5
	move(motion)
	
	if (is_colliding()):
		var n = get_collision_normal()
		motion = n.slide(motion)
		velocity = n.slide(velocity)
		move(motion)
	
	check_health()
	
	if !global.dead:
		check_state()
	if hurting == true:
		if hurtloop < 8:
			hurtcount += delta
			if hurtcount > 0.12:
				if is_visible():
					hide()
				else:
					show()
				hurtcount = 0
				hurtloop += 1
		else:
			hurting = false
			show()

func check_state():
	if velocity.y > 0:
		sprite.set_animation("fall")
	elif velocity.y < 0:
		sprite.set_animation("jump")
	if lfoot.is_colliding() || rfoot.is_colliding():
		if velocity.x == 0:
			sprite.set_animation("idle")
		elif velocity.x != 0:
			sprite.set_animation("run")
	if (left.is_colliding() || right.is_colliding()) && (!lfoot.is_colliding() || rfoot.is_colliding()):
		sprite.set_animation("wall")
	if velocity.x < 0:
		if sprite.is_flipped_h():
			sprite.set_flip_h(false)
	elif velocity.x > 0:
		if !sprite.is_flipped_h():
			sprite.set_flip_h(true)

func check_health():
	if global.health > 75:
		sprite = asprite[0]
	elif global.health > 50:
		sprite = asprite[1]
	elif global.health > 25:
		sprite = asprite[2]
	else:
		sprite = asprite[3]
	for i in asprite:
		i.hide()
	sprite.show()

func _hurt(h):
	if !hurting && !global.dead:
		global.health -= h
		hurting = true
		hurtloop = 0
		global.sfx.play("Hurt")
		check_health()

func _heal(h):
	global.health += h
	if global.health > 100:
		global.health = 100
	global.sfx.play("Heart")
	check_health()

func _die():
	check_health()
	global.dead = true
	sprite.set_animation("die")
	hurting = false
	if sprite.get_frame() == 12:
		get_parent()._dieMenu()

func _rez():
	check_health()
	sprite.set_animation("rez")
	sprite.set_frame(0)

func _gravity(grav):
	set_gravity_scale(grav)