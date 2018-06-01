extends Area2D

export var heart = "courage"

func _ready():
	get_node("AnimatedSprite").set_animation(heart)
	get_node("Label").set_text(heart)


func _on_Area2D_body_enter( body ):
	if body.is_in_group("Player"):
		body._heal(50)
		queue_free()
