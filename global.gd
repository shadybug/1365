extends Node

var talking = false
var presspause = false
var health = 100
var player

func _ready():
	pass

func _new_level( body ):
	player = body
