extends Popup

func _ready():
	set_process(true)

func _process(delta):
	if Input.is_action_pressed("ui_cancel") && !global.presspause:
		if get_node("RichTextLabel").is_visible():
			get_node("VBoxContainer").show()
			get_node("RichTextLabel").hide()
			get_node("Back").hide()
			global.presspause = true
		else:
			get_tree().set_pause(false)
			hide()
			global.presspause = true
	
	if !Input.is_action_pressed("ui_cancel") && global.presspause:
		global.presspause = false

func _on_Continue_pressed():
	get_tree().set_pause(false)
	hide()

func _on_Quit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://mainmenu.tscn")
	global._restart()

func _on_About_pressed():
	get_node("VBoxContainer").hide()
	get_node("RichTextLabel").show()
	get_node("Back").show()
	get_node("Back").grab_focus()

func _on_Back_pressed():
	get_node("VBoxContainer").show()
	get_node("RichTextLabel").hide()
	get_node("Back").hide()
	get_node("VBoxContainer/About").grab_focus()
