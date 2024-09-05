extends CharacterBody2D


var player_in_area = false


func _process(delta):
	if player_in_area:
		if Input.is_action_just_pressed("use"):
			run_dialogue("Sailor_timeline")



func run_dialogue(dialogue_string):
	var layout = Dialogic.start(dialogue_string)
	layout.register_character(load("res://Dialogic/characters/Sailor.dch"),$"." )

func _on_dialog_trigger_body_entered(body):
	if body.has_method("player"):
		player_in_area = true


func _on_dialog_trigger_body_exited(body):
	if body.has_method("player"):
		player_in_area = false
