class_name enemygold
extends Node2D

@export var stats: EnemyStats
var gold = 0
@onready var gold_label: Label = %GoldText

func _ready():
	gold = stats.gold_drop
	gold_label.text = str(gold)

func _on_continue_button_pressed():
	print("fight should close...")
	Events.battle_close.emit()
