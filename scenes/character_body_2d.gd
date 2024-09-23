extends CharacterBody2D

@export var SPEED = 300.0

@export var speed = 400

var target = position
var target_node

var combo = '':
	set(value):
		combo = value
		if len(combo) == 4:
			if combo == 'wwww':
				print('Теперь ты всегда выигрываешь в нарды у армян')
			elif combo == 'erer':
				print('Ближайший арбуз в 10 км от тебя')
			else:
				print('Неверно')
			combo = ''

func _ready() -> void:
	target_node = $"../target"
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 1)
	await tween.finished

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('RClick'):
		target = get_global_mouse_position()
		target_node.position = get_global_mouse_position()
		target_node.visible = true
	if event.is_action_pressed('q'):
		combo += 'q'
	elif event.is_action_pressed('w'):
		combo += 'w'
	elif event.is_action_pressed('e'):
		combo += 'e'
	elif event.is_action_pressed('r'):
		combo += 'r'


func _physics_process(delta: float) -> void:
	velocity = position.direction_to(target) * speed
	if position.distance_to(target) > 10:
		move_and_slide()
	else:
		target_node.visible = false
