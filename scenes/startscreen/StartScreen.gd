class_name StartScreen extends Node

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "5922ISDK"

var player_data = PlayerData.new()
var current_world : String = "404 not found"


func _on_button_button_up() -> void:
	SceneManager.load_new_scene("res://scenes/openworld/alotushuonetesti1.tscn","fade_to_black")



func _on_load_button_pressed():
	load_data(SAVE_DIR + SAVE_FILE_NAME)


func load_data(path: String):
	if FileAccess.file_exists(path):
		var file = FileAccess.open_encrypted_with_pass(path, FileAccess.READ, SECURITY_KEY)
		if file == null:
			print(FileAccess.get_open_error())
			return
		
		var content = file.get_as_text()
		file.close()
		
		var data = JSON.parse_string(content)
		if data == null:
			printerr("Cannot parse as a json_string")
			return
		
		player_data = PlayerData.new()
		#position not needed atm
		player_data.health = data.player_data.health
		player_data.global_positionx = data.player_data.global_positionx
		player_data.global_positiony = data.player_data.global_positiony
		player_data.world = data.player_data.world
		teleport_player()
	
	else:	 
		printerr("cannot open non-existent file")


func teleport_player():
	SceneManager.load_new_scene(player_data.world,"fade_to_black")
