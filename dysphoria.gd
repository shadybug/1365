extends RigidBody2D

var time = 0

var play

func _ready():
	randomize()
	if randf() >= 0.5:
		get_node("sprite").set_animation("pink")
		get_node("Light2D").set_color("d77bba")
	set_process(true)
	
func _process(delta):
	if time > 0.1:
		var xy = Vector2((randf() * 100 - 50), (randf() * 100 - 50))
		set_linear_velocity(xy)
		time = 0
	else:
		time += delta

func _on_playerArea_body_enter( body ):
	if body.is_in_group("Player"):
		body._hurt(2)