extends Node2D

func _ready() -> void:
	GlobalWorldEnvironment.environment.adjustment_saturation = 1
	AudioServer.set_bus_effect_enabled(0, 0, false)
	AudioServer.set_bus_effect_enabled(0, 1, false)

func finished() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/Start menu.tscn")
