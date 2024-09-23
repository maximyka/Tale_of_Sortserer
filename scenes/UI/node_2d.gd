extends Node2D

func _ready() -> void:
	GlobalWorldEnvironment.environment.adjustment_brightness = 0
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 1)
	await tween.finished

func Start_button() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 0, 1)
	await tween.finished
	var mainscene = load("res://scenes/test.tscn")
	get_tree().change_scene_to_packed(mainscene)


func _on_quit_pressed() -> void:
	get_tree().quit()


func _on_credits_pressed() -> void:
	var mainscene = load("res://scenes/UI/credits.tscn")
	get_tree().change_scene_to_packed(mainscene)
