class_name Player extends CharacterBody2D

@export var move_speed : float = 100
@export var input_enabled:bool = true
@export var player_gold = 0


@onready var anim = $Playeranim


var angle = 0
var current_animation = "new_idle"
var a = 0			#animaatioita varten
var speed = 200
var gold = 0


func _process(delta):
	current_animation="new_idle"
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir.length() != 0:
		a = input_dir.angle() / (PI/4)
		a = wrapi(int(a), 0,8)
		current_animation = "new_walk"
	velocity = input_dir * speed
	if Input.is_action_pressed("sprint") && input_dir.length() != 0:
		velocity *= 2
		current_animation = "new_run"
		
	move_and_slide()
	$Playeranim.play(current_animation+ str(a))


func disable():
	speed = 0
	current_animation = "new_idle"
	
func enable():
	speed = 200



func _on_market_1_movementlock():
	speed = 0


func _on_shop_movementresume():
	speed = 200


func player():
	pass
	

func _on_area_2d_playermovementlock():
	speed = 0

func _ready():
	Events.battle_won.connect(enable)
	Events.battle_lost.connect(enable)
