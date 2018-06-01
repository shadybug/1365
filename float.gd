extends Node2D

export var group = "dysphoria"
export var offsety = 8
var nodes = []
var time = 0.2
var closest = 0
var distance = 1000000

func _ready():
	get_node("Sprite/Label").set_text(group)
	set_process(true)
	nodes = get_tree().get_nodes_in_group(group)

func _process(delta):
	time += delta
	if time > 0.03:
		time = 0
		closest = 0
		distance = 1000000
		for i in nodes:
			if i.get_global_pos().distance_to(global.player.get_global_pos()) < distance:
				distance = i.get_global_pos().distance_to(global.player.get_global_pos())
				closest = i
		set_global_pos(Vector2(closest.get_global_pos().x, closest.get_global_pos().y - offsety))