extends Node2D

export var scene = "res://level0.tscn"
export var day = "0000"

func _ready():
	global._new_level(get_node("player"))
	get_node("CanvasLayer/health")._day(day)
	set_process(true)
	global.talking = false

func _process(delta):
	if Input.is_action_pressed("ui_cancel") && !global.presspause:
		get_tree().set_pause(true)
		get_node("CanvasLayer/Pause").show()
		global.presspause = true
	if !global.talking:
		if global.health <= 0:
			global.player._die()

func _on_exit_body_enter( body ):
	if body.is_in_group("Player"):
		#get_tree().change_scene(scene)
		transitionfade.fade_to(scene)
		body.set_linear_velocity(Vector2(0,0))
		global.talking = true

func _dieMenu():
	get_tree().set_pause(true)
	get_node("CanvasLayer/Die").show()