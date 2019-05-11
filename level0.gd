extends Node2D

export var scene = "res://level0.tscn"
export var day = "0000"
var exiting = false

var speech

func _ready():
	global._new_level(get_node("player"), get_node("CanvasLayer/SamplePlayer"))
	get_node("CanvasLayer/Control/health")._day(day)
	set_process(true)
	global.talking = false	
	
	speech = get_node("CanvasLayer/Control/Speech")
	
	get_node("CanvasLayer/Control").get_theme().set_default_font(load(global.font2))
	get_node("CanvasLayer/Control").get_theme().set_font("font","Label",load(global.font))
	get_node("CanvasLayer/Control").get_theme().set_font("normal_font","RichTextLabel",load(global.font))

func _process(delta):
	if Input.is_action_pressed("ui_cancel") && !global.presspause:
		get_tree().set_pause(true)
		get_node("CanvasLayer/Control/Pause").show()
		get_node("CanvasLayer/Control/Pause/VBoxContainer/Continue").grab_focus()
		global.presspause = true
	if !global.talking:
		if global.health <= 0:
			global.player._die()
	if exiting && !global.talking:
		exiting = false
		transitionfade.fade_to(scene)
		global.talking = true
	speech.set_pos(get_node("player").get_global_transform_with_canvas().o-Vector2(speech.get_size().x/2,speech.get_size().y+80))
	if get_node("player").sprite.is_flipped_h():
		if speech.get_size().x-32 < 88:
			speech.get_node("Tail").set_global_pos(get_node("player").get_global_transform_with_canvas().o-Vector2(16,80))
		else:
			speech.get_node("Tail").set_global_pos(get_node("player").get_global_transform_with_canvas().o-Vector2(44,80))
		speech.get_node("Tail").set_flip_h(false)
	else:
		if speech.get_size().x-32 < 88:
			speech.get_node("Tail").set_global_pos(get_node("player").get_global_transform_with_canvas().o-Vector2(-16,80))
		else:
			speech.get_node("Tail").set_global_pos(get_node("player").get_global_transform_with_canvas().o-Vector2(-28,80))
		speech.get_node("Tail").set_flip_h(true)
	if speech.get_pos().x > 1300-speech.get_size().x:
		speech.set_pos(Vector2(1300-speech.get_size().x,speech.get_pos().y))
	elif speech.get_pos().x < 0:
		speech.set_pos(Vector2(0,speech.get_pos().y))
	if speech.get_pos().y > 700:
		speech.set_pos(Vector2(speech.get_pos().x,700-speech.get_size().y))
	elif speech.get_pos().y < 0:
		speech.set_pos(Vector2(speech.get_pos().x,0))

func _on_exit_body_enter( body ):
	if body.is_in_group("Player"):
		body.velocity = (Vector2(0,0))
		if !global.talking:
			transitionfade.fade_to(scene)
			global.talking = true
		else:
			exiting = true

func _dieMenu():
	get_tree().set_pause(true)
	get_node("CanvasLayer/Control/Die").show()
	get_node("CanvasLayer/Control/Die/VBoxContainer/Continue").grab_focus()