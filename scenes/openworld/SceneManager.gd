extends Node


signal content_finished_loading(content)
signal content_invalid(content_path:String)
signal content_failed_to_load(content_path:String)

var loading_screen:LoadingScreen
var _loading_screen_scene:PackedScene = preload("res://scenes/openworld/loading_screen.tscn")
var _transition:String
var _content_path:String
var _load_progress_timer:Timer

func _ready() -> void:
	content_invalid.connect(on_content_invalid)
	content_failed_to_load.connect(on_content_failed_to_load)
	content_finished_loading.connect(on_content_finished_loading)
	
func load_new_scene(content_path:String, transition_type:String="fade_to_black") -> void:
	_transition = transition_type
	loading_screen = _loading_screen_scene.instantiate() as LoadingScreen
	get_tree().root.add_child(loading_screen)
	loading_screen.start_transition(transition_type)
	_load_content(content_path)
	


func _load_content(content_path:String) -> void:
	
	# zelda transition doesn't use a loading screen - personal preference
	if loading_screen != null:
		await loading_screen.transition_is_complete
		
	_content_path = content_path
	var loader = ResourceLoader.load_threaded_request(content_path)
	if not ResourceLoader.exists(content_path) or loader == null:
		content_invalid.emit(content_path)
		return 		
	
	_load_progress_timer = Timer.new()
	_load_progress_timer.wait_time = 0.1
	_load_progress_timer.timeout.connect(monitor_load_status)
	get_tree().root.add_child(_load_progress_timer)
	_load_progress_timer.start()

func monitor_load_status() -> void:
	var load_progress = []
	var load_status = ResourceLoader.load_threaded_get_status(_content_path, load_progress)

	match load_status:
		ResourceLoader.THREAD_LOAD_INVALID_RESOURCE:
			content_invalid.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			if loading_screen != null:
				loading_screen.update_bar(load_progress[0] * 100) # 0.1
		ResourceLoader.THREAD_LOAD_FAILED:
			content_failed_to_load.emit(_content_path)
			_load_progress_timer.stop()
			return
		ResourceLoader.THREAD_LOAD_LOADED:
			_load_progress_timer.stop()
			_load_progress_timer.queue_free()
			content_finished_loading.emit(ResourceLoader.load_threaded_get(_content_path).instantiate())

	
func on_content_failed_to_load(path:String) -> void:
	printerr("error: Failed to load resource: '%s'" % [path])
	
func on_content_invalid(path:String) -> void:
	printerr("error: Cannot load resource: '%s'" % [path])
	
func on_content_finished_loading(content) -> void:
	var outgoing_scene = get_tree().current_scene
	
	# If we're moving between Levels, pass LevelDataHandoff here
	var incoming_data:LevelDataHandoff
	if  get_tree().current_scene is Level:
		incoming_data = get_tree().current_scene.data as LevelDataHandoff
	
	if content is Level:
		content.data = incoming_data


	outgoing_scene.queue_free()
	

	get_tree().root.call_deferred("add_child",content)
	get_tree().set_deferred("current_scene",content)
	

	if loading_screen != null:
		loading_screen.finish_transition()
		if content is Level:
			content.init_player_location()
		await loading_screen.anim_player.animation_finished
		loading_screen = null
		if content is Level:
			content.enter_level()	
