class_name Level extends Node2D

@export var player:Player
@export var doors:Array[Door]
var data:LevelDataHandoff

var fight_num: String = "null" 


func _ready() -> void:
	player.disable()
	#player.visible = false
	if data == null:
		enter_level()
	Events.battle_won.connect(enemy_dead_signal)
	SaveMenu.enemy_set()


func enter_level() -> void:
	if data != null:
		init_player_location()
	player.enable()
	_connect_to_doors()
	#tää saaattaa olla parempi tässä 
	#SaveMenu.enemy_set()
	
func init_player_location() -> void:
	#if data != null:
	#	for door in doors:
	#		$Player.position.x = door.teleport_posx
	#		$Player.position.y = door.teleport_posy
	print("1")
			#print(door.teleport_posx)
			#print(door.teleport_posy)
	var doors = find_children("*","Door")
	if data != null:
		print("2")
		for door in doors:
			print("3")
			if door.name == data.entry_door_name:
				player.position = door.get_player_entry_pos()
				print("teleport")
		#player.orient(data.move_dir)
		
func _on_player_entered_door(door:Door) -> void:
	_disconnect_from_doors()
	player.disable()
	player.queue_free()
	data = LevelDataHandoff.new()
	data.entry_door_name = door.entry_door_name
	data.move_dir = door.get_move_dir()
	set_process(false)
	
func _connect_to_doors() -> void:
	for door in doors:
		if not door.player_entered_door.is_connected(_on_player_entered_door):
			door.player_entered_door.connect(_on_player_entered_door)

func _disconnect_from_doors() -> void:
	for door in doors:
		if door.player_entered_door.is_connected(_on_player_entered_door):
			door.player_entered_door.disconnect(_on_player_entered_door)

func enemy_dead_signal():
	if fight_num != "null":
		get_node("%"+str(fight_num)).visible = false
		get_node("%"+str(fight_num)+"/CollisionShape2D").disabled = true
		
	fight_num = "null"
