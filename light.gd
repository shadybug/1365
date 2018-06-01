extends Light2D

export var offchance = 0.1
export var flickerchance = 0.4

func _ready():
	randomize()
	if randf() <= offchance:
		set_enabled(false)
	get_node("AnimationPlayer").set_speed(0)
	if randf() <= flickerchance:
		get_node("AnimationPlayer").set_speed(randf()*200)
