extends Area2D

var changing = false
var i = 0

func _ready():
	set_process(true)

func _process(delta):
	if changing:
		if i > 20:
			get_node("sprite").set_animation("SKREE")
			changing = false
		i += 1

func _on_standard_body_enter( body ):
	if body.is_in_group("Player"):
		body._hurt(50)


func _on_Area2D_body_enter( body ):
	if body.is_in_group("Player"):
		get_node("sprite").set_animation("change")
		changing = true
