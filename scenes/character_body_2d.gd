extends CharacterBody2D
@export var speed = 400

var speeding = 0
var target
var target_node

@export var loc = 'city'

@onready var camera: Camera2D = $Camera2D
@onready var player_anim: AnimatedSprite2D = $Player

var combo = '':
	set(value):
		combo = value
		if len(combo) == 4:
			$UI/AnimatedSprite2D.visible = true
			$UI/AnimatedSprite2D.play('react')
			if combo == 'wwww':
				print('Теперь ты всегда выигрываешь в нарды у армян')
			elif combo == 'erer':
				print('Ближайший арбуз в 10 км от тебя')
			else:
				print('Неверно')
			combo = ''

func _ready() -> void:
	match loc:
		'city':
			camera.zoom = Vector2(1.72, 1.72)
			camera.limit_bottom = 650
			camera.limit_right = 1350
			camera.limit_left = -1350
			camera.limit_top = -650
		'circus':
			camera.zoom = Vector2(2.2, 2.2)
			camera.limit_bottom = 650
			camera.limit_right = 1150
			camera.limit_left = 0
			camera.limit_top = 0
		'museum':
			camera.zoom = Vector2(2.2, 2.2)
			camera.limit_bottom = 650
			camera.limit_right = 1150
			camera.limit_left = 0
			camera.limit_top = -150
		'start':
			camera.zoom = Vector2(2.2, 2.2)
			camera.limit_bottom = 500
			camera.limit_right = 950
			camera.limit_left = 250
			camera.limit_top = 0
	$UI/AnimatedSprite2D.visible = false
	target_node = $"../../target"
	target = target_node.position
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 1, 1)
	await tween.finished

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed('RClick'):
		var pos = get_global_mouse_position()
		target = pos
		target_node.position = pos
		target_node.visible = true
		if position.x - pos.x <= 0:
			$Player.flip_h = false
		else:
			$Player.flip_h = true
	if event.is_action_pressed('q'):
		combo += 'q'
	elif event.is_action_pressed('w'):
		combo += 'w'
	elif event.is_action_pressed('e'):
		combo += 'e'
	elif event.is_action_pressed('r'):
		combo += 'r'


func _physics_process(delta: float) -> void:
	if speeding < speed:
		speeding+=1200*delta
	velocity = position.direction_to(target) * speeding
	if position.distance_to(target) > 10:
		player_anim.play('Run')
		move_and_slide()
	else:
		speeding = 0
		player_anim.play('Idle')
		target_node.visible = false


func _on_animated_sprite_2d_animation_finished() -> void:
	$UI/AnimatedSprite2D.visible = false
