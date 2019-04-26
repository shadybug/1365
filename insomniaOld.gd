extends RigidBody2D

var sprite
var forward
var speed = 30
var grav = 40

var speedVec = Vector2(speed, 0)
var gravVec = Vector2(0, grav)
export var direction = 0 #left
var cw = 1 #direction the insomnia goes (var name shortened from "clockwise")

var dead = false
var hurtloop = 0
var hurtcount = 0

export var flipped = false
var rotate = 0

func _ready():
	sprite = get_node("sprite")
	forward = get_node("forward")
	forward.add_exception(self)
	
	if !flipped:
		#set_axis_velocity(Vector2(speed,grav))
		sprite.set_flip_v(true)
		set_rot(PI)
		rotate = PI
	else:
		#set_axis_velocity(Vector2(-speed,grav))
		cw = -1
		speed = speed*cw
		speedVec = Vector2(speed, 0)
	
	var startVec = Vector2(speed,grav)
	
	if direction == 0: #left
		if flipped:
			set_axis_velocity(startVec)
		else:
			speedVec = speedVec.rotated(cw*PI)
			gravVec = gravVec.rotated(cw*PI)
			rotate(cw*PI)
			set_axis_velocity(startVec.rotated(cw*PI))
	elif direction == 1: #up
		speedVec = speedVec.rotated(cw*3*PI/2)
		gravVec = gravVec.rotated(cw*3*PI/2)
		rotate(cw*3*PI/2)
		set_axis_velocity(startVec.rotated(cw*3*PI/2))
	elif direction == 2: #right
		if flipped:
			speedVec = speedVec.rotated(cw*PI)
			gravVec = gravVec.rotated(cw*PI)
			rotate(cw*PI)
			set_axis_velocity(startVec.rotated(cw*PI))
		else:
			set_axis_velocity(startVec)
	else: #down
		speedVec = speedVec.rotated(cw*PI/2)
		gravVec = gravVec.rotated(cw*PI/2)
		rotate(cw*PI/2)
		set_axis_velocity(startVec.rotated(cw*PI/2))
	set_process(true)

func _process(delta):
	if dead:
#		if hurtloop < 8:
#			hurtcount += delta
#			if hurtcount > 0.10:
#				if is_visible():
#					hide()
#				else:
#					show()
#				hurtcount = 0
#				hurtloop += 1
		set_opacity(get_opacity()-0.008)
		if get_opacity() < 0.01:
			queue_free()
	
	if forward.is_colliding():
		rotate(cw*PI/2)
		speedVec = speedVec.rotated(cw*PI/2)
		gravVec = gravVec.rotated(cw*PI/2)
		
		# oh if only godot 2 had switch statements
		if direction == 0: #left
			set_pos(Vector2(get_pos().x-16,get_pos().y-16))
		elif direction == 1: #up
			set_pos(Vector2(get_pos().x-16,get_pos().y+16))
		elif direction == 2: #right
			set_pos(Vector2(get_pos().x+16,get_pos().y+16))
		else: #down
			set_pos(Vector2(get_pos().x+16,get_pos().y-16))
		direction += 1*cw
		if direction > 3:
			direction = 0
		elif direction < 0:
			direction = 3
	
	if sprite.get_frame() == 4 || sprite.get_frame() == 9:
		set_axis_velocity(speedVec)
	
	if sprite.get_frame() == 7 || sprite.get_frame() == 2:
		set_axis_velocity(gravVec)

func _on_playerArea_body_enter( body ):
	if body.is_in_group("Player"):
		sprite.set_animation("die")
		dead = true
		set_linear_velocity(Vector2(0,0))