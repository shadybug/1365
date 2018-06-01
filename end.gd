extends Control

var textArray = ["1365\n\nby Cicada Scott","Font\n\nLittle Monster\nby Jack Oatley","I don't know how much time I have left in me, but I'm going to keep kicking until the bitter end.","As long as I'm here, I'm winning. It won't be easy, but then, life never was, and I know that I'm not alone. I can't let my demons win over me. There's still something worth fighting for.","There's still everything worth fighting for.","You keep fighting, too."]
var text = ""
var talking = true
var talk = 0
var i = 0
var t = 0

var enter = true

func _ready():
	text = textArray[talk]
	talking = true
	i = 0
	set_process(true)

func _process(delta):
	if talking == true && i <= text.length():
		if t > 0.04:
			get_node("Label").set_text(text.left(i))
			i += 1
			t = 0
	elif i > text.length():
		talking = false
	t += delta
	
	if Input.is_action_pressed("ui_accept"):
		if !enter:
			if i <= text.length():
				i = text.length()
				enter = true
				pass
			if i > text.length() && talk < 5:
				talk += 1
				text = textArray[talk]
				talking = true
				i = 0
		enter = true
	
	if !Input.is_action_pressed("ui_accept"):
		enter = false
	if talking == false && talk >= 5:
		get_node("END").show()

func _on_END_pressed():
	get_tree().change_scene("res://mainmenu.tscn")
