extends StaticBody2D

var ready_to_space = false

func _ready() -> void:
	$CanvasLayer.visible = false
	$Label.visible = false

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_accept") and ready_to_space:
		$CanvasLayer.visible = [true, false][int($CanvasLayer.visible)]

func _on_area_2d_body_entered(_body: Node2D) -> void:
	ready_to_space = true
	$Label.visible = true
func _on_area_2d_body_exited(_body: Node2D) -> void:
	ready_to_space = false
	$Label.visible = false
