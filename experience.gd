extends Node

@export var characterlevel : int
@export var xp = 0
@export var xp_required = 100
var node_index

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$bar.region_rect = Rect2(0, 0, 0, 0)
	Events.battle_close.connect(hide)
#
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass


func level_up() -> void:
	characterlevel = characterlevel + 1
	xp_required = xp_required + 10
	print("level up!")
	print("current level")
	print(characterlevel)
	
func experience_calc() -> void:
	$"/root/experience".visible = true
	print("gained 10 xp")
	xp =  xp + 10
	print(xp)
	if xp >= xp_required:
		level_up()
		xp = 0
		$bar.region_rect = Rect2(0, 0, 0, 0)
	else:
		var border_width = 1256.08
		var repeats_required = xp_required / 10
		var repeat_width = border_width / repeats_required
		
		var repeats_current = xp/10
		$bar.region_rect = Rect2(0, 0, repeats_current * 64, 128)
		$bar.scale = Vector2((repeat_width - characterlevel*0.04)/64, 0.422)
		print(repeats_required - repeats_current * 1.5)



func _on_button_pressed():
	experience_calc()

func hide():
	$"/root/experience".visible = false
