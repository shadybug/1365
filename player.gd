extends RigidBody2D

var sprite
var asprite = []
var feet
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
	feet = get_node("feet")
	right = get_node("right")
	left = get_node("left")
	feet.add_exception(self)
	feet.add_exception(right)
	feet.add_exception(left)
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
	
	if !global.talking:
		if feet.is_colliding():
			if Input.is_action_pressed("ui_up") && !jumping:
				set_axis_velocity(Vector2(0,-400))
				jumping = true
			if Input.is_action_pressed("ui_left") && hspeed > -max_speed && !left.is_colliding():
				set_axis_velocity(Vector2(hspeed - 30,0))
			if Input.is_action_pressed("ui_right") && hspeed < max_speed && !right.is_colliding():
				set_axis_velocity(Vector2(hspeed + 30,0))
		if !Input.is_action_pressed("ui_up"):
			jumping = false
		
		if !feet.is_colliding():
			if left.is_colliding():
				set_axis_velocity(Vector2(0,20))
				if Input.is_action_pressed("ui_left") && Input.is_action_pressed("ui_up"):
					set_axis_velocity(Vector2(200,-600))
			if right.is_colliding():
				set_axis_velocity(Vector2(0,20))
				if Input.is_action_pressed("ui_right") && Input.is_action_pressed("ui_up"):
					set_axis_velocity(Vector2(-200,-600))
			
			if Input.is_action_pressed("ui_left") && hspeed > -max_air_speed && !left.is_colliding():
				set_axis_velocity(Vector2(hspeed - 30,0))
			if Input.is_action_pressed("ui_right") && hspeed < max_air_speed && !right.is_colliding():
				set_axis_velocity(Vector2(hspeed + 30,0))
	
	check_health()
	
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
	if feet.is_colliding():
		if hspeed == 0:
			sprite.set_animation("idle")
		elif hspeed != 0:
			sprite.set_animation("run")
	if (left.is_colliding() || right.is_colliding()):
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
	if !hurting:
		global.health -= h
		hurting = true
		hurtloop = 0
		check_health()

func _heal(h):
	global.health += h
	if global.health > 100:
		global.health = 100
	check_health()