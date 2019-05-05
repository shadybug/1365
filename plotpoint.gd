extends Area2D

export var text = ""
var talking = false
export var fall = false
var i = 0
var t = 0

func _ready():
	set_process(true)

func _process(delta):
	if talking == true && i <= text.length():
		if t > 0.01:
			get_parent().get_node("CanvasLayer/Control/Label").set_text(text.left(i))
			global.sfx.play("Anxiety")
			i += 1
			t = 0
	elif i > text.length():
		talking = false
		global.talking = false
		queue_free()
	t += delta

func _on_Area2D_body_enter( body ):
	if body.is_in_group("Player"):
		talking = true
		global.talking = true
		i = 0
		if fall:
			body.velocity.x = 0
