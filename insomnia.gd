extends PathFollow2D

var sprite
var light

var dead = false
var born = true
var loop = 0
var count = 0

export var flipped = true
var positive = 1

func _ready():
	sprite = get_node("sprite")
	light = get_node("Light2D")
	set_opacity(0)
	
	randomize()
	if randf() > 0.5:
		flipped = false
		positive = -1
	else:
		sprite.set_flip_h(true)
		light.set_scale(Vector2(-1, 1))
	
	set_process(true)

func _process(delta):
	if born:
		if loop < 8:
			count += delta
			if count > 0.15:
				if is_visible():
					hide()
				else:
					show()
				count = 0
				loop += 1
				set_opacity(get_opacity()+0.05)
		else:
#		set_opacity(get_opacity()-0.008)
#		if get_opacity() < 0.01:
			show()
			set_opacity(1)
			count = 0
			loop = 0
			born = false
	
	if dead:
		if loop < 8:
			count += delta
			if count > 0.15:
				if is_visible():
					hide()
				else:
					show()
				count = 0
				loop += 1
				set_opacity(get_opacity()-0.05)
		else:
#		set_opacity(get_opacity()-0.008)
#		if get_opacity() < 0.01:
			queue_free()
		return
	
	if sprite.get_animation() == "default":
		if sprite.get_frame() == 5:
			light.set_texture_offset(Vector2(2,0))
		if sprite.get_frame() == 9:
			light.set_texture_offset(Vector2(0,0))
	
	if (sprite.get_frame() > 3 && sprite.get_frame() < 7) || sprite.get_frame() > 8 || sprite.get_frame() <2:
		set_offset(get_offset() + (positive*30*delta))

func _on_playerArea_body_enter( body ):
	if body.is_in_group("Player"):
		sprite.set_animation("die")
		dead = true
		light.set_texture_offset(Vector2(4,-16))