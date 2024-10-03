extends Area2D

signal laituri1

var entered = false

func _on_body_entered(body):
	entered=true


func _on_body_exited(body):
	entered=false

func _process(delta):
	if entered == true:
		if Questsystem.quest1Accepted == true:
			if Input.is_action_just_pressed("use"):
				Questsystem.quest1done = true
				print("1234")
