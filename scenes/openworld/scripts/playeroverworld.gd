extends CharacterBody2D

@export var move_speed : float = 100

@onready var anim = $player


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
		current_animation = "idle"
	velocity = input_dir * speed
	if Input.is_action_pressed("sprint"):
		velocity *= 2
	move_and_slide()




func Paavo():
	pass

