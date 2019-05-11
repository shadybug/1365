extends Area2D

export var text = ""
var stringSize = Vector2(0,0)
var talking = false
export var fall = false
var i = 0
var t = 0
var label
var speech

func _ready():
	speech = get_parent().get_node("CanvasLayer/Control/Speech")
	label = speech.get_node("Label")
	set_process(true)

func _process(delta):
	if talking == true && i <= text.length():
		if t > 0.01:
			label.set_text(text.left(i))
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
		stringSize = label.get_font(global.fontName).get_string_size(text)
		if (stringSize.x) < 248:
			speech.set_size(Vector2(stringSize.x+36,stringSize.y+32))
		else:
			speech.set_size(Vector2(280,((label.get_line_height()*ceil(stringSize.x/220))+32)))
		label.set_size(speech.get_size() - Vector2(32,16))
		speech.get_node("Panel").set_size(speech.get_size() - Vector2(16,0))
		speech.get_node("Panel1").set_size(speech.get_size() - Vector2(0,16))
		label.set_pos(Vector2(16,8))
		speech.get_node("Panel").set_pos(Vector2(8,0))
		speech.get_node("Panel1").set_pos(Vector2(0,8))
		speech.get_node("TopLeft").set_pos(Vector2(0,1))
		speech.get_node("TopRight").set_pos(Vector2(speech.get_size().x-16,1))
		speech.get_node("BottomLeft").set_pos(Vector2(0,speech.get_size().y-15))
		speech.get_node("BottomRight").set_pos(Vector2(speech.get_size().x-16,speech.get_size().y-15))
		if !speech.is_visible():
			speech.show()
		i = 0
		if fall:
			body.velocity.x = 0
