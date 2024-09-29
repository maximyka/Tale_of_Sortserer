extends Control

@onready var animation_player: AnimationPlayer = $Panel/AnimationPlayer
var count_texts = 0
@export var max_texts = 8:
	set(value):
		if value > 8:
			max_texts = 8
		elif value < 0:
			max_texts = 0
		else:
			max_texts = value
@export var object_name = ''

@export var text1 = ''
@export var text2 = ''
@export var text3 = ''
@export var text4 = ''
@export var text5 = ''
@export var text6 = ''
@export var text7 = ''
@export var text8 = ''

func _ready() -> void:
	$Panel/Label.text = object_name

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and !animation_player.is_playing() and get_parent().visible:
		if count_texts == max_texts:
			get_parent().visible = false
			count_texts = 0
			
			match object_name:
				'Музей':
					get_tree().change_scene_to_file("res://scenes/museum_lvl.tscn")
				'Цирк':
					Global.after = get_parent().name
					get_tree().change_scene_to_file("res://scenes/circus_lvl.tscn")
				'Выход':
					Global.after = get_parent().name
					get_tree().change_scene_to_file("res://scenes/test.tscn")
				'Дверь':
					get_tree().change_scene_to_file("res://scenes/UI/loading.tscn")
					
		match count_texts:
			0:
				$Panel/RichTextLabel.text = text1
				animation_player.play('a')
			1:
				$Panel/RichTextLabel.text = text2
				animation_player.play('a')
			2:
				$Panel/RichTextLabel.text = text3
				animation_player.play('a')
			3:
				$Panel/RichTextLabel.text = text4
				animation_player.play('a')
			4:
				$Panel/RichTextLabel.text = text5
				animation_player.play('a')
			5:
				$Panel/RichTextLabel.text = text6
				animation_player.play('a')
			6:
				$Panel/RichTextLabel.text = text7
				animation_player.play('a')
			7:
				$Panel/RichTextLabel.text = text8
				animation_player.play('a')

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	count_texts += 1
