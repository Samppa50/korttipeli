extends CanvasLayer

func _ready():
	get_node("container").hide()



func  _process(delta):
	if Input.is_action_just_pressed("tab"):
		get_tree().paused = !get_tree().paused
		get_node("container").visible = get_tree().paused
		hideGUI()


func _on_quest_pressed():
	hideGUI()
	$container/Quest.show()



func _on_cards_pressed():
	hideGUI()



func hideGUI():
	$container/Quest.hide()
