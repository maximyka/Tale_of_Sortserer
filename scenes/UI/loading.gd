extends Control

var sceneName
var scene_load_status = 0

func _ready() -> void:
	GlobalWorldEnvironment.environment.adjustment_brightness = 1
	sceneName = "res://scenes/test.tscn"
	ResourceLoader.load_threaded_request(sceneName)


func _process(_delta: float) -> void:
	scene_load_status = ResourceLoader.load_threaded_get_status(sceneName)
	if scene_load_status == ResourceLoader.THREAD_LOAD_LOADED:
		var newScene = ResourceLoader.load_threaded_get(sceneName)
		GlobalWorldEnvironment.environment.adjustment_brightness = 0
		get_tree().change_scene_to_packed(newScene)
