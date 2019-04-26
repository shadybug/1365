extends RigidBody2D

var insomnia = load("res://insomnia.tscn")
var instance
var time = 0
var container

export var spawnrate = 0.99

var forward
#var speed = 80
#var grav = 0.1

var offset = Vector2(200, 0)

#var speedVec = Vector2(speed, 0)
#var gravVec = Vector2(0, grav)
#var vec = Vector2(speed, grav)
var direction = 0 #left
var cw = 1 #direction the insomnia goes (var name shortened from "clockwise")

var flipped = false

func _ready():
	forward = get_node("forward")
	forward.add_exception(self)
	randomize()
	if randf() > 0.5:
		set_rot(PI)
		direction = 2
	else:
		cw = -1
		offset = offset.rotated(PI)
		flipped = true
	print(flipped)
	set_process(true)

func _process(delta):	
	if forward.is_colliding():
		print((forward.get_collider().get_path()))
		rotate(cw*PI/2)
		offset = offset.rotated(cw*PI/2)
		
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
	time += delta
	if time > 0.05:
		move(offset.x, offset.y)
		time = 0
		
		randomize()
		if randf() > spawnrate:
			instance = insomnia.instance()
			container = get_node("container")
			instance.set_pos(get_pos())
			instance.direction = direction
			instance.flipped = flipped
			container.add_child(instance)

func move(x, y):
	set_axis_velocity(Vector2(x, y))