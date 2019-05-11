extends Control

var textArray = ["1365\n\nby Cicada Carpenter","Fonts\n\nLittle Monster\nby Jack Oatley\n\nOpen Dyslexic\nby Abbie Gonzalez\n\nLiberation Sans\nby Red Hat","Special Thanks\n\nBlair Hollow        Brandi Mendieta        Amy Rockenbach\nVV Oakley        Alicia Seidle        The Godot community\nAnd everyone who helped debug and playtest,\n\nFor believing in me","And thanks to:\n\nGodot        Mini2DX        GIMP\nTiled        Aseprite        Krita\nFL Studio        Bfxr\n\nI couldn't have done it without you.","I don't know how much time I have left in me, but I'm going to keep kicking until the bitter end.","As long as I'm here, I'm winning. It won't be easy, but then, life never was, and I know that I'm not alone. I can't let my demons win over me. There's still something worth fighting for.","There's still everything worth fighting for.","You keep fighting, too."]
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
	get_theme().set_default_font(load(global.font))

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
			if i > text.length() && talk < 7:
				talk += 1
				text = textArray[talk]
				talking = true
				i = 0
		enter = true
	
	if !Input.is_action_pressed("ui_accept"):
		enter = false
	if talking == false && talk >= 7:
		get_node("END").show()
		get_node("CONTINUE").hide()

func _on_END_pressed():
	transitionfade.fade_to("res://mainmenu.tscn")


func _on_CONTINUE_pressed():
	if !enter:
		if i <= text.length():
			i = text.length()
			enter = true
			pass
		if i > text.length() && talk < 7:
			talk += 1
			text = textArray[talk]
			talking = true
			i = 0
	enter = true