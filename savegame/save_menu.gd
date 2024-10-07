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
	level_get()
	Quest_get()
	var file = FileAccess.open_encrypted_with_pass(path, FileAccess.WRITE, SECURITY_KEY)
	if file == null:
		print(FileAccess.get_open_error())
		return
	var data = { 
		"player_data": {
			"health": player_data.health,
			"global_positionx": player_data.global_positionx,
			"global_positiony": player_data.global_positiony,
			"world": player_data.world,
			"player_level": player_data.player_level,
			"player_xp": player_data.player_xp,
			"player_needed_xp": player_data.player_needed_xp,
			"Questaccepted": player_data.Questaccepted,
			"Questdone": player_data.Questdone,
			"player_gold": player_data.player_gold
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
		player_data.player_level = data.player_data.player_level
		player_data.player_xp = data.player_data.player_xp
		player_data.player_needed_xp = data.player_data.player_needed_xp
		player_data.Questaccepted = data.player_data.Questaccepted
		player_data.Questdone = data.player_data.Questdone
		player_data.player_gold = data.player_data.player_gold
		teleport_player()
		level_set()
		Quest_set()
	
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

func level_set():
	experience.characterlevel = player_data.player_level
	experience.xp = player_data.player_xp
	experience.xp_required = player_data.player_needed_xp
	print(experience.characterlevel)
	print(experience.xp)

func level_get():
	player_data.player_level = experience.characterlevel
	player_data.player_xp = experience.xp
	player_data.player_needed_xp = experience.xp_required

func Quest_set():
	Questsystem.quest1Accepted = player_data.Questaccepted
	Questsystem.quest1done = player_data.Questdone
	
func Quest_get():
	player_data.Questaccepted = Questsystem.quest1Accepted
	player_data.Questdone = Questsystem.quest1done
	
func gold_set():
	#kulta kannattaa varmaan yhdistää suoraan kauppaaan eikä pelaajaan
	pass
	
func gold_get():
	pass
