class_name StartScreen extends Control

func _on_button_button_up() -> void:
	SceneManager.load_new_scene("res://scenes/openworld/level1.tscn","fade_to_black")

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("ui_accept"):
		SceneManager.load_new_scene("res://scenes/openworld/level1.tscn","fade_to_black")
