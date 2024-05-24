extends Area2D

@export var new_scene: PackedScene

func _input(event):
	if event.is_action_pressed("use"):
		if get_overlapping_bodies().size() > 0:
			next_level()

func next_level():
	var PTS = get_tree().change_scene_to_packed(new_scene)
