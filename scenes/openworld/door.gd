class_name Door extends Area2D

signal player_entered_door(door: Door,transition_type: String)

@export_enum("north","east","south","west") var entry_dir
@export_enum("fade_to_black") var transition_type:String
@export var push_distance:int = 16
@export var path_to_new_scene:String
@export var entry_door_name:String
@export var teleport_posx:int = 0
@export var teleport_posy:int = 0


func _on_body_entered(body: Node2D) -> void:
	if not body is Player:
		return
	player_entered_door.emit(self)
	SceneManager.load_new_scene(path_to_new_scene,transition_type)
	queue_free()
	
func get_player_entry_pos() -> Vector2:
	var vector:Vector2 = Vector2.LEFT
	match entry_dir:
		0:
			vector = Vector2.UP
		1: 
			vector = Vector2.RIGHT
		2:
			vector = Vector2.DOWN
	return (vector * push_distance) + self.position
	
