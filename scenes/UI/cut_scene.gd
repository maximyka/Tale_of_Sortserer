extends Node2D

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept"):
		_on_animated_sprite_2d_animation_finished()

func _on_animated_sprite_2d_frame_changed() -> void:
	GlobalWorldEnvironment.environment.adjustment_brightness = 0
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 0.2)
	await tween.finished
	var tween2 = get_tree().create_tween()
	tween2.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 0.2)



func _on_animated_sprite_2d_animation_finished() -> void:
	get_tree().change_scene_to_file("res://scenes/UI/Start menu.tscn")
