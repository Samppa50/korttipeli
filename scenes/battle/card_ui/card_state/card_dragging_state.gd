extends cardstate

const min_drag_threshold := 0.1
var min_drag_time_elapsed := false

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)
	
	card_ui.panel.set("theme_override_styles/panel", card_ui.DRAG_STYLEBOX)
	Events.card_drag_started.emit(card_ui)
	
	min_drag_time_elapsed = false
	var threshold_timer := get_tree().create_timer(min_drag_threshold, false)
	threshold_timer.timeout.connect(func(): min_drag_time_elapsed = true)
	
func exit() -> void:
	Events.card_drag_ended.emit(card_ui)
	
	
func on_input(event: InputEvent) -> void:
	var single_targeted := card_ui.card.is_single_targeted()
	var mouse_motion := event is InputEventMouseMotion
	var cancel = event.is_action_pressed("right_mouse")
	var confirm = event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")
	
	if single_targeted and mouse_motion and card_ui.targests.size() > 0:
		transition_requested.emit(self, cardstate.State.AIMING)
		return
	
	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
	
	if cancel:
		transition_requested.emit(self, cardstate.State.BASE)
	elif min_drag_time_elapsed and confirm:
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, cardstate.State.RELEASED)
