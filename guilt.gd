extends RigidBody2D

var sprite
var hspeed
var vspeed
var speed = 15

var time = 0

func _ready():
	sprite = get_node("sprite")
	set_axis_velocity(Vector2(speed,0))
	
	set_process(true)
	
func _process(delta):
	hspeed = get_linear_velocity().x
	vspeed = get_linear_velocity().y
	
	randomize()
	if time > 400 && randf() > 0.95:
		set_linear_velocity(Vector2(speed,0))
		time = 0
	
	if sprite.get_frame() == 0:
		set_axis_velocity(Vector2(0,randf()*-10))
	
	if hspeed < 0:
		if sprite.is_flipped_h():
			sprite.set_flip_h(false)
			speed = 15
	if hspeed > 0:
		if !sprite.is_flipped_h():
			sprite.set_flip_h(true)
			speed = -15
			
	time += 1

func _on_playerArea_body_enter( body ):
	if body.is_in_group("Player"):
		body._hurt(10)