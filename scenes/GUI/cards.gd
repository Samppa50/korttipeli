extends Node2D

const BASE_STYLEBOX :=preload("res://scenes/battle/card_ui/card_style.tres")
const DRAG_STYLEBOX :=preload("res://scenes/battle/card_ui/glow_card_style.tres")
const HOVER_STYLEBOX :=preload("res://scenes/battle/card_ui/hover_card_style.tres")

var deck: CardPile
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	# Create a Control node
	print(deck.cards[0].id)
	#var control_node = Control.new()
	#
	## Apply the StyleBox to the Control node
	#control_node.add_stylebox_override("panel", BASE_STYLEBOX)
	#
	## Add the Control node as a child of the current Node2D
	#add_child(control_node)
#
	##new_card_ui.reparent_requested.connect(_on_card_ui_reparent_requested)
	#new_card_ui.card = card
	#new_card_ui.parent = self
	#new_card_ui.char_stats = char_stats	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

#func _on_visuals_mouse_entered() -> void:
	#panel.set("theme_override_styles/panel", HOVER_STYLEBOX)
	#
#func _on_visuals_mouse_excited() -> void:
	#panel.set("theme_override_styles/panel", BASE_STYLEBXO)
	#
#func set_card(value: Card) -> void:
	#if not is_node_ready():
		#await ready
