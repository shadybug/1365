extends Control

func _ready():
	set_process(true)
	get_node("VBoxContainer/Start Game").grab_focus()

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_node("Panel").hide()

func _on_Start_Game_pressed():
	transitionfade.fade_to("res://level0.tscn")

func _on_About_pressed():
	get_node("Panel").show()
	get_node("VBoxContainer").hide()
	get_node("Panel/Back").grab_focus()
	
func _on_Back_pressed():
	get_node("Panel").hide()
	get_node("VBoxContainer").show()
	get_node("VBoxContainer/About").grab_focus()

func _on_Settings_pressed():
	get_node("Panel1").show()
	get_node("VBoxContainer").hide()
	get_node("Panel1/Back1").grab_focus()
	
func _on_Back1_pressed():
	get_node("Panel1").hide()
	get_node("VBoxContainer").show()
	get_node("VBoxContainer/Settings").grab_focus()

func _on_Talking_Buttons_button_selected( button_idx ):
	if button_idx == 0:
		global.stopntalk = true
	else:
		global.stopntalk = false

func _on_Flickering_Buttons_button_selected( button_idx ):
	if button_idx == 0:
		global.flicker = true
	else:
		global.flicker = false