extends Control

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 1)
	$AnimationPlayer.play("a")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_on_quit_pressed()

func _on_quit_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 0, 1)
	await tween.finished
	var mainscene = load("res://scenes/UI/Start menu.tscn")
	get_tree().change_scene_to_packed(mainscene)
