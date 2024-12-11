extends Node2D

var player_data = PlayerData.new()


func save_teleport_player():
	var player = get_node("./Player")
	#player_data.global_positionx = player.position.x
	#player_data.global_positiony = player.position.y
	
	player_data.world = "res://scenes/openworld/"+str(get_parent().name)+".tscn"
	print("res://scenes/openworld/"+str(get_parent().name)+".tscn")
	SaveMenu.player_data.world = player_data.world
	#lähetetään maailmadata savemenuun tallennusta varten


func _on_button_pressed():
	#save_data(SAVE_DIR + SAVE_FILE_NAME)
	save_teleport_player()
	SaveMenu.save_taverna()

func _on_area_2d_body_entered(node):
	$Button.visible = !$Button.visible


func _on_area_2d_body_exited(body):
	$Button.visible = !$Button.visible
	
