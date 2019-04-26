extends Control

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_node("Panel").hide()

func _on_Start_Game_pressed():
	transitionfade.fade_to("res://level0.tscn")

func _on_About_pressed():
	get_node("Panel").show()
	
func _on_Back_pressed():
	get_node("Panel").hide()
