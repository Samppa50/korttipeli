class_name cardUI
extends Control

signal reparent_requested(which_card_ui: cardUI)

const BASE_STYLEBOX :=preload("res://scenes/battle/cards_ui/card_style.tres")
const DRAG_STYLEBOX :=preload("res://scenes/battle/cards_ui/glow_card_style.tres")
const HOVER_STYLEBOX :=preload("res://scenes/battle/cards_ui/hover_card_style.tres")

@export var card: Card : set = _set_card
@export var char_stats: CharacterStats

@onready var cost = $Cost
@onready var icon = $Icon
@onready var panel = $Panel
@onready var drop_point_detector = $droppoindetector
@onready var card_state_machine: CardStateMachine = $cardstatemachine as CardStateMachine
@onready var targets: Array[Node] =  []


func _ready() -> void:
	card_state_machine.init(self)
	
func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)
	
func play() -> void:
	if not card:
		return
	card.play(targets, char_stats)
	queue_free()
	
func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)
	
func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()
	
func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()
	
func _set_card(value: Card) -> void:
	if not is_node_ready():
		await ready
	
	card = value
	cost.text = str(card.cost)
	icon.texture = card.icon


func _on_droppoindetector_area_entered(area):
	if not targets.has(area):
		targets.append(area)


func _on_droppoindetector_area_exited(area):
	targets.erase(area)
