extends RigidBody2D
# using a rigidbody probably wasn't a good idea. kinematicbody is allegedly better
# 	for characters in simple games like this

var sprite
var asprite = []
var lfoot
var rfoot
var left
var right
var hspeed
var vspeed

var hurting = false
var hurtloop = 0
var hurtcount = 0

var jumping = true

const max_speed = 150
const max_air_speed = 75

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
	set_process(true)
	
func _process(delta):
	hspeed = get_linear_velocity().x
	vspeed = get_linear_velocity().y
	
	if sprite.get_frame() == 16:
		global.dead = false
		sprite.set_animation("idle")
		_hurt(0)
	
	if !global.talking && !global.dead:
		if lfoot.is_colliding() || rfoot.is_colliding():
			if Input.is_action_pressed("ui_up") && !jumping:
				set_axis_velocity(Vector2(0,-400))
				jumping = true
			if Input.is_action_pressed("ui_left") && hspeed > -max_speed && !left.is_colliding():
				set_axis_velocity(Vector2(hspeed - 30,0))
			if Input.is_action_pressed("ui_right") && hspeed < max_speed && !right.is_colliding():
				set_axis_velocity(Vector2(hspeed + 30,0))
			if Input.is_action_pressed("ui_down") && (lfoot.get_collider().is_in_group("locker") || rfoot.get_collider().is_in_group("locker")):
				set_pos(Vector2(get_pos().x, get_pos().y+2))
		if !Input.is_action_pressed("ui_up"):
			jumping = false
		
		if !lfoot.is_colliding() || !rfoot.is_colliding():
#			if left.is_colliding():
#				set_axis_velocity(Vector2(0,20))
#				if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_up"):
#					set_axis_velocity(Vector2(250,-450))
#			if right.is_colliding():
#				set_axis_velocity(Vector2(0,20))
#				if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_up"):
#					set_axis_velocity(Vector2(-250,-450))
			
			if Input.is_action_pressed("ui_left") && hspeed > -max_air_speed && !left.is_colliding():
				set_axis_velocity(Vector2(hspeed - 30,0))
			if Input.is_action_pressed("ui_right") && hspeed < max_air_speed && !right.is_colliding():
				set_axis_velocity(Vector2(hspeed + 30,0))
	
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
	if vspeed > 0:
		sprite.set_animation("fall")
	elif vspeed < 0:
		sprite.set_animation("jump")
	if lfoot.is_colliding() || rfoot.is_colliding():
		if hspeed == 0:
			sprite.set_animation("idle")
		elif hspeed != 0:
			sprite.set_animation("run")
	if (left.is_colliding() || right.is_colliding()) && (!lfoot.is_colliding() || rfoot.is_colliding()):
		sprite.set_animation("wall")
	if hspeed < 0:
		if sprite.is_flipped_h():
			sprite.set_flip_h(false)
	elif hspeed > 0:
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
		check_health()

func _heal(h):
	global.health += h
	if global.health > 100:
		global.health = 100
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