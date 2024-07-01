class_name Player extends CharacterBody2D

@export var move_speed : float = 100
@export var input_enabled:bool = true


@onready var anim = $Playeranim


var angle = 0
var current_animation = "idle"
var a = 0			#animaatioita varten
var speed = 200



func _process(delta):
	current_animation="idle"
	
	var input_dir = Input.get_vector("left", "right", "up", "down")
	if input_dir.length() != 0:
		a = input_dir.angle() / (PI/4)
		a = wrapi(int(a), 0,8)
		current_animation = "walk"
	velocity = input_dir * speed
	if Input.is_action_pressed("sprint"):
		velocity *= 2
		current_animation = "run"
		
	move_and_slide()
	$Playeranim.play(current_animation)
	#+ str(a)


func disable():
	input_enabled = false
	current_animation = "idle"
	
func enable():
	input_enabled = true
	visible = true

