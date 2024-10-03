extends Area2D

signal playermovementlock
var entered = false
var simultaneus_scene = preload("res://scenes/battle/level/battle.tscn").instantiate()


func _on_body_entered(body : PhysicsBody2D):
	entered = true


func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("use"):
			#get_tree().change_scene_to_file("res://scenes/battle/level/battle.tscn")
			#SceneManager.load_new_scene("res://scenes/battle/level/battle.tscn","fade_to_black")
			#get_tree().paused = true
			emit_signal("playermovementlock")
			_add_a_scene_manually()

func _add_a_scene_manually():
	get_tree().root.add_child(simultaneus_scene)

