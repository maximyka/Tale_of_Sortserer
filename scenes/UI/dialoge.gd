extends Control

@onready var animation_player: AnimationPlayer = $Panel/AnimationPlayer
var count_texts = 0
@export var max_texts = 2

func _process(delta: float) -> void:
	if Input.is_anything_pressed() and count_texts <= max_texts+1 and !animation_player.is_playing():
		match count_texts:
			0:
				$Panel/RichTextLabel.text = 'ADFUASGHCJKFASGBHJaskcdxhaskjbckjfhsdgbjsdfvsdvc sdcfsdcfasd'
				animation_player.play('a')
			1:
				$Panel/RichTextLabel.text = 'ADFUASGHCJKFAfhsdgbasd'
				animation_player.play('a')
			2:
				$Panel/RichTextLabel.text = 'ADFUgbasd'
				animation_player.play('a')
			3:
				get_parent().visible = false
				count_texts = 0


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	count_texts += 1
