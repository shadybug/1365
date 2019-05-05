extends Node

var talking = false
var presspause = false
var dead = false
var health = 100
var player
var sfx

var stopntalk = true
var flicker = true
var sfxOn = true
var musicOn = true

func _ready():
	pass

func _new_level( body1, body2 ):
	player = body1
	sfx = body2
	if !sfxOn:
		sfx.set_default_volume(0)
	if !musicOn:
		transitionfade.get_node("StreamPlayer").set_volume(0)

func _restart():
	health = 100
	talking = false
	presspause = false
	dead = false