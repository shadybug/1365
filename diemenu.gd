extends Popup

func _ready():
	pass

func _on_Continue_pressed():
	get_tree().set_pause(false)
	global.health = 50
	global.player._rez()
	hide()

func _on_Quit_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://mainmenu.tscn")
	global._restart()
