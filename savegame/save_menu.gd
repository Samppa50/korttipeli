extends Node2D

const SAVE_DIR = "user://saves/"
const SAVE_FILE_NAME = "save.json"
const SECURITY_KEY = "5922ISDK"

var player_data = PlayerData.new()
var current_world : String = "404 not found"



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

func _on_save_button_pressed():
	save_data(SAVE_DIR + SAVE_FILE_NAME)


func _on_load_button_pressed():
	load_data(SAVE_DIR + SAVE_FILE_NAME)
	
func teleport_player():
	#print("res://scenes/openworld/"+str(get_parent().name)+".tscn")
	#pitänee tehdä levelien nimistä sellasia että niissä ei ole _ niin voidaan getparent namella vaihtaa joskus skeneä

	SceneManager.load_new_scene(player_data.world,"fade_to_black")
	#await get_tree().create_timer(2).timeout
	#SceneManager.load_new_scene("res://scenes/openworld/"+str(get_parent().name)+".tscn","fade_to_black")
	#if player_data.global_positionx != 0 && player_data.global_positiony != 0:
	#	await get_tree().create_timer(2).timeout
	#	$Player.position.x = player_data.global_positionx
	#	$Player.position.y = player_data.global_positiony
	#	print("teleporting to")
	#	print(player_data.global_positionx)
	#	print(player_data.global_positiony)
	#else:
	#	print("no location to teleport to")

func save_teleport_player():
	var player = get_node("./Player")
	player_data.global_positionx = player.position.x
	player_data.global_positiony = player.position.y
	
	player_data.world = "res://scenes/openworld/"+str(get_parent().name)+".tscn"
	print("res://scenes/openworld/"+str(get_parent().name)+".tscn")
