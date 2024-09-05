extends Area2D

signal movementlock

var entered = false

func _on_body_entered(body):
	entered=true


func _on_body_exited(body):
	entered=false


func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("use"):
			get_node("Shop").show()
			emit_signal("movementlock")
