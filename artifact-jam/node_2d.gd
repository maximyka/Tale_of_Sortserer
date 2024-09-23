extends Node2D




func Start_button() -> void:
	var mainscene = load("res://test.tscn")
	get_tree().change_scene_to_packed(mainscene)
