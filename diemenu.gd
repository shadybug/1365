extends Popup

func _ready():
	pass

func _on_Continue_pressed():
	get_tree().set_pause(false)
	global.health = 100
	hide()

func _on_Quit_pressed():
	get_tree().change_scene("res://mainmenu.tscn")
