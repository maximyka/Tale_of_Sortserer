extends CharacterBody2D
@export var speed = 400
var speeding = 0

var target = position
var target_node

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
	$UI/AnimatedSprite2D.visible = false
	target_node = $"../../target"
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
