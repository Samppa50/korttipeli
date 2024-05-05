class_name cardUI
extends Control

signal reparent_requested(which_card_ui: cardUI)

@onready var color: ColorRect = $color
@onready var state: Label = $state
@onready var drop_point_detector = $droppoindetector
@onready var card_state_machine: CardStateMachine = $cardstatemachine as CardStateMachine
@onready var targets: Array[Node] =  []

func _ready() -> void:
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()


func _on_droppoindetector_area_entered(area):
	if not targets.has(area):
		targets.append(area)


func _on_droppoindetector_area_exited(area):
	targets.erase(area)
