extends Area2D

signal fight_num
signal playermovementlock
var entered = false
var simultaneus_scene = preload("res://scenes/battle/level/battle.tscn").instantiate()

var current_fight : String = "null"


func _on_body_entered(body : PhysicsBody2D):
	entered = true
	current_fight = self.name


func _on_body_exited(body):
	entered = false


func _process(delta):
	if entered == true:
		if Input.is_action_just_pressed("use"):
			if get_node("%"+current_fight).visible == true:
				emit_signal("playermovementlock")
				_add_a_scene_manually()

func _add_a_scene_manually():
	get_tree().root.add_child(simultaneus_scene)

func _ready():
	Events.battle_won.connect(enemy_dead)

func enemy_dead():
	if current_fight != "null":
		get_parent().fight_num = current_fight
		print(get_parent().fight_num)
		SaveMenu.softsave = current_fight
		print(SaveMenu.softsave)
		SaveMenu.enemy_get()
		current_fight = "null"
	current_fight = "null"
	
	Events.battle_saved.emit()
