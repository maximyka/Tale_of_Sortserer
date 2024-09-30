extends CharacterBody2D
@export var speed = 400

var racketa = preload("res://scenes/Magic/fire_show.tscn")
var lemon = preload("res://scenes/Magic/lemon.tscn")
var banan = preload("res://scenes/Magic/banan.tscn")

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
			if combo == 'qqrr': #Лимонная долька
				var skill = lemon.instantiate()
				skill.position = position + Vector2(0, -40)
				get_parent().add_child(skill)
				if loc == 'final':
					Global.win = true
			elif combo == 'wrrw': #Смена цвета
				var tween = get_tree().create_tween()
				tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_saturation', 0, 0.2)
				$Color.start(10)
				if loc == 'museum':
					Global.count_talk_museum = 3
			elif combo == 'qwer': #Банановая кожура
				var skill = banan.instantiate()
				skill.position = position + Vector2(30, 0)
				get_parent().add_child(skill)
			elif combo == 'qrqr': #фейрверк
				var skill = racketa.instantiate()
				skill.position = get_global_mouse_position()
				get_parent().add_child(skill)
			elif combo == 'eeqq': #фонарь
				var tween = get_tree().create_tween()
				tween.parallel().tween_property($PointLight2D, 'texture_scale', 1, 0.2)
				tween.parallel().tween_property($PointLight2D, 'energy', 0.4, 0.2)
				$Lighting.start(10)
			elif combo == 'erre': #Мелодия
				AudioServer.set_bus_effect_enabled(0, 0, true)
				AudioServer.set_bus_effect_enabled(0, 1, true)
				$Music.start(5)
			else:
				print('Неверно')
			combo = ''

func _ready() -> void:
	GlobalWorldEnvironment.environment.adjustment_saturation = 1
	AudioServer.set_bus_effect_enabled(0, 0, false)
	AudioServer.set_bus_effect_enabled(0, 1, false)
	match loc:
		'city':
			camera.zoom = Vector2(1.72, 1.72)
			camera.limit_bottom = 650
			camera.limit_right = 1350
			camera.limit_left = -1350
			camera.limit_top = -650
		'circus':
			camera.zoom = Vector2(2, 2)
			camera.limit_bottom = 650
			camera.limit_right = 1650
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
		'final':
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
		$UI/HBoxContainer/q/GPUParticles2D.emitting = true
	elif event.is_action_pressed('w'):
		$UI/HBoxContainer/w/GPUParticles2D.emitting = true
		combo += 'w'
	elif event.is_action_pressed('e'):
		$UI/HBoxContainer/e/GPUParticles2D.emitting = true
		combo += 'e'
	elif event.is_action_pressed('r'):
		$UI/HBoxContainer/r/GPUParticles2D.emitting = true
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


func _on_lighting_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.parallel().tween_property($PointLight2D, 'texture_scale', 0.3, 0.2)
	tween.parallel().tween_property($PointLight2D, 'energy', 0.15, 0.2)


func _on_color_timeout() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_saturation', 1, 0.2)


func _on_music_timeout() -> void:
	AudioServer.set_bus_effect_enabled(0, 0, false)
	AudioServer.set_bus_effect_enabled(0, 1, false)


func _on_exit_pressed() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(GlobalWorldEnvironment, 'environment:adjustment_brightness', 0, 0.5)
	await tween.finished
	get_tree().change_scene_to_file("res://scenes/UI/Start menu.tscn")
