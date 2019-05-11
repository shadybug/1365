extends Control

var fontList = ["Little Monster","OpenDyslexic3","Liberation Sans"]

func _ready():
	set_process(true)
	get_node("VBoxContainer/Start Game").grab_focus()
	
	var settings = get_node("Panel1/HBoxContainer")
	
	var fontDrop = settings.get_node("VBoxContainer 2/Font Dropdown")
	
	for i in range(3):
		fontDrop.add_item(fontList[i],i)
	
	# remember settings
	if global.stopntalk:
		settings.get_node("VBoxContainer 2/Talking Buttons").set_selected(0)
	else:
		settings.get_node("VBoxContainer 2/Talking Buttons").set_selected(1)
	if global.flicker:
		settings.get_node("VBoxContainer 2/Flickering Buttons").set_selected(0)
	else:
		settings.get_node("VBoxContainer 2/Flickering Buttons").set_selected(1)
	if global.musicOn:
		settings.get_node("VBoxContainer 2/Music Buttons").set_selected(0)
	else:
		settings.get_node("VBoxContainer 2/Music Buttons").set_selected(1)
	if global.sfxOn:
		settings.get_node("VBoxContainer 2/Sfx Buttons").set_selected(0)
	else:
		settings.get_node("VBoxContainer 2/Sfx Buttons").set_selected(1)
	if global.font == "res://opendyslexic.fnt":
		fontDrop.select(1)
	elif global.font == "res://liberationsans.fnt":
		fontDrop.select(2)
	else:
		fontDrop.select(0)

func _process(delta):
	if Input.is_action_pressed("ui_cancel"):
		get_node("Panel").hide()

func _on_Start_Game_pressed():
	transitionfade.fade_to("res://level0.tscn")

func _on_About_pressed():
	get_node("Panel").show()
	get_node("VBoxContainer").hide()
	get_node("TextureFrame 2").hide()
	get_node("Panel/Back").grab_focus()
	
func _on_Back_pressed():
	get_node("Panel").hide()
	get_node("VBoxContainer").show()
	get_node("TextureFrame 2").show()
	get_node("VBoxContainer/About").grab_focus()

func _on_Settings_pressed():
	get_node("Panel1").show()
	get_node("VBoxContainer").hide()
	get_node("TextureFrame 2").hide()
	get_node("Panel1/Back1").grab_focus()
	
func _on_Back1_pressed():
	get_node("Panel1").hide()
	get_node("VBoxContainer").show()
	get_node("TextureFrame 2").show()
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

func _on_Music_Buttons_button_selected( button_idx ):
	if button_idx == 0:
		global.musicOn = true
	else:
		global.musicOn = false

func _on_Sfx_Buttons_button_selected( button_idx ):
	if button_idx == 0:
		global.sfxOn = true
	else:
		global.sfxOn = false

func _on_Font_Dropdown_item_selected( index ):
	if index == 1:
		global.font = "res://opendyslexic.fnt"
		global.font2 = "res://opendyslexic2.fnt"
		global.fontName = "opendyslexic"
	elif index == 2:
		global.font = "res://liberationsans.fnt"
		global.font2 = "res://liberationsans2.fnt"
		global.fontName = "liberationsans"
	else:
		global.font = "res://littlemonster.fnt"
		global.font2 = "res://littlemonster2.fnt"
		global.fontName = "littlemonster"
	get_theme().set_default_font(load(global.font2))
	get_theme().set_font("font","Label",load(global.font2))
	get_theme().set_font("normal_font","RichTextLabel",load(global.font))


func _on_HSlider_value_changed( value ):
	global.gameSpeed = value
	OS.set_time_scale(value)
