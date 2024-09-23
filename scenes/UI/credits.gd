extends Control

func _ready() -> void:
	$AnimationPlayer.play("a")



func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	_on_quit_pressed()

func _on_quit_pressed() -> void:
	var mainscene = load("res://scenes/UI/Start menu.tscn")
	get_tree().change_scene_to_packed(mainscene)
