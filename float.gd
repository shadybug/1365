extends Node2D

export var group = "dysphoria"
export var offsety = 8
export var flipped = false
var offsetx = 0
var nodes = []
var time = 0.2
var closest = 0
var distance = 1000000

func _ready():
	get_node("Sprite/Label").set_text(group)
	set_process(true)
	if group != "insomnia":
		nodes = get_tree().get_nodes_in_group(group)
	if flipped:
		get_node("Sprite").set_flip_v(true)
		get_node("Sprite/Label").set_pos(Vector2(-25,-5))

func _process(delta):
	time += delta
	if group == "insomnia":
		pass
	if time > 0.03:
		time = 0
		closest = 0
		distance = 1000000
		if group == "insomnia":
			nodes = get_tree().get_nodes_in_group(group)
		if !nodes.empty():
			for i in nodes:
				if i.get_global_pos().distance_to(global.player.get_global_pos()) < distance:
					distance = i.get_global_pos().distance_to(global.player.get_global_pos())
					closest = i
			if group == "insomnia":
				offsety = closest.get_node("sprite").get_sprite_frames().get_frame("default",0).get_size().x / 2 + 4
#				if closest.direction == 1 || closest.direction == 3:
#					offsety = 28
#				else:
#					offsety = 12
			set_global_pos(Vector2(closest.get_global_pos().x - offsetx, closest.get_global_pos().y - offsety))
			if !is_visible():
				show()
		else:
			hide()