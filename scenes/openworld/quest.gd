extends Control




func _process(delta):
	if Questsystem.quest1Accepted:
		get_node("Quests").text = "Fights Won: " + str(Questsystem.fights_won)
	else:
		get_node("Quests").text = "No Quests Active "
		
