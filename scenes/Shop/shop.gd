extends Node2D

@export var player:Player

signal movementresume

func _ready():
	self.hide()





func _on_close_pressed():
	self.hide()
	emit_signal("movementresume")
