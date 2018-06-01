extends AnimationPlayer

func _ready():
	set_speed(0)
	randomize()
	if randf() <= 0.4:
		set_speed(randf()*200)
