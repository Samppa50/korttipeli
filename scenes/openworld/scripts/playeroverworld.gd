class_name Player extends CharacterBody2D

@export var move_speed : float = 100
@export var input_enabled:bool = true


@onready var anim = $Playeranim


var angle = 0
var current_animation = "idle"
var a = 0			#animaatioita varten
var speed = 200
var gold = 0


func _process(delta):
	current_animation="idle"
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir.length() != 0:
		a = input_dir.angle() / (PI/4)
		a = wrapi(int(a), 0,8)
		current_animation = "walk"
	velocity = input_dir * speed
	if Input.is_action_pressed("sprint") && input_dir.length() != 0:
		velocity *= 2
		current_animation = "run"
		
	move_and_slide()
	$Playeranim.play(current_animation)
	#+ str(a)


func disable():
	speed = 0
	current_animation = "idle"
	
func enable():
	speed = 200



func _on_market_1_movementlock():
	speed = 0


func _on_shop_movementresume():
	speed = 200
