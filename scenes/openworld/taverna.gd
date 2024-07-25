extends Node2D

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "5922ISDK"

var player_data = PlayerData.new()


func _ready():
	verify_save_directory(SAVE_DIR)

func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

func save_data(path: String):
	save_teleport_player()
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
	var data = { 
		"player_data": {
			"health": player_data.health,
			"global_positionx": player_data.global_positionx,
			"global_positiony": player_data.global_positiony,
			"world": player_data.world
		}
	}
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()

func save_teleport_player():
	var player = get_node("./Player")
	#player_data.global_positionx = player.position.x
	#player_data.global_positiony = player.position.y
	
	player_data.world = "res://scenes/openworld/"+str(get_parent().name)+".tscn"
	print("res://scenes/openworld/"+str(get_parent().name)+".tscn")





func _on_button_pressed():
	save_data(SAVE_DIR + SAVE_FILE_NAME)





func _on_area_2d_body_entered(node):
	$Button.visible = !$Button.visible


func _on_area_2d_body_exited(body):
	$Button.visible = !$Button.visible
