extends cardstate


# Called when the node enters the scene tree for the first time.
func enter() -> void:
	if not card_ui.is_node_ready():
		await card_ui.ready

	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
	card_ui.reparent_requested.emit(card_ui)
	card_ui.pivot_offset = Vector2.ZERO
	
func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		transition_requested.emit(self, cardstate.State.CLICKED)
		
func on_mouse_entered() -> void:
	card_ui.panel.set("theme_override_styles/panel", card_ui.HOVER_STYLEBOX)
	
func on_mouse_exited() -> void:
	card_ui.panel.set("theme_override_styles/panel", card_ui.BASE_STYLEBOX)
