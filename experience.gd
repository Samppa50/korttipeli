extends Node

@export var characterlevel : int
@export var xp = 0
@export var xp_required = 100


func level_up() -> void:
	characterlevel = characterlevel + 1
	xp_required = xp_required + 10
	print("level up!")
	print("current level")
	print(characterlevel)
	
func experience_calc() -> void:
	print("gained 10 xp")
	xp =  xp + 10
	print(xp)
	if xp >= xp_required:
		level_up()
		xp = 0


func _on_button_pressed():
	experience_calc()
