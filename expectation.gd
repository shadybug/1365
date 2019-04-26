extends Area2D

var changing = false
var big = false
var i = 0

func _on_expectation_body_enter( body ):
	if body.is_in_group("Player"):
		body._hurt(50)

func _on_Area2D_body_enter( body ):
	if body.is_in_group("Player"):
		big = false
		get_node("sprite").set_animation("change")
		changing = true

func _on_Area2D_body_exit( body ):
	if body.is_in_group("Player"):
		big = true
		get_node("sprite").set_animation("change2")
		changing = true

func _on_sprite_finished():
	if big && changing:
		get_node("sprite").set_animation("idle")
		changing = false
		big = false
	elif !big && changing:
		get_node("sprite").set_animation("SKREE")
		changing = false
		big = true