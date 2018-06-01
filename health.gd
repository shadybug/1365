extends AnimatedSprite
var sprites = []
var active

func _ready():
	sprites = [get_node("health0"), get_node("health1"), get_node("health2"), get_node("health3"), get_node("health4"), get_node("health5"), get_node("health6"), get_node("health7"), get_node("health8"), get_node("health9"), get_node("health10")]
	active = sprites[0]
	set_process(true)

func _process(delta):
	if global.health > 90:
		active = sprites[0]
	elif global.health > 80:
		active = sprites[1]
	elif global.health > 70:
		active = sprites[2]
	elif global.health > 60:
		active = sprites[3]
	elif global.health > 50:
		active = sprites[4]
	elif global.health > 40:
		active = sprites[5]
	elif global.health > 30:
		active = sprites[6]
	elif global.health > 20:
		active = sprites[7]
	elif global.health > 10:
		active = sprites[8]
	elif global.health > 0:
		active = sprites[9]
	else:
		active = sprites[10]
	for i in sprites:
		i.hide()
	active.show()
	active.set_value(100 - global.health)

func _day(d):
	d = d.replace("0","o")
	print(d)
	get_node("day").set_text(d)