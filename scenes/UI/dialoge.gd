extends Control

@onready var animation_player: AnimationPlayer = $Panel/AnimationPlayer

func _process(delta: float) -> void:
	if Input.is_anything_pressed():
		$Panel/RichTextLabel.text = 'ADFUASGHCJKFASGBHJaskcdxhaskjbckjfhsdgbjsdfvsdvc sdcfsdcfasd'
		animation_player.play('a')
