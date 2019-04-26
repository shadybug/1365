extends CanvasLayer

var scn = ""

func fade_to(scn_path):
	self.scn = scn_path
	get_node("AnimationPlayer").play("fade")

func change_scene():
	if scn != "":
		get_tree().change_scene(scn)
	if scn == "res://end.tscn":
		get_node("StreamPlayer").stop()