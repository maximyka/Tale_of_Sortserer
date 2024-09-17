extends MeshInstance3D

var ready_to_press = false
var action_after_pressed = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_up") and ready_to_press:
		if action_after_pressed:
			var action_after_pressed = true
			print(1)
		else:
			print(0)
			var action_after_pressed = false


func _on_area_3d_body_entered(body: Node3D) -> void:
	ready_to_press = true


func _on_area_3d_body_exited(body: Node3D) -> void:
	ready_to_press = false
