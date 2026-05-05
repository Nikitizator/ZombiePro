extends CharacterBody2D

const SPEED = 300.0

# Система хп
@export var max_health : float = 100.0
var current_health : float
@export var regen_amount_per_second : float = 1.0  # хп за 1 секунду

#ссылка на узел
@onready var health_bar = $healthbar

func _ready():
	current_health = max_health
	if health_bar:
		health_bar.max_value = max_health
		health_bar.value = current_health

#обновление хилбара
func update_health_bar():
	if health_bar:
		health_bar.value = current_health
		var progress_style = health_bar.get_theme_stylebox("progress")
		if progress_style and current_health < max_health * 0.3:
			progress_style.bg_color = Color(1, 0, 0)
		elif progress_style:
			progress_style.bg_color = Color(0, 1, 0)

func _physics_process(delta):

	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * SPEED
	move_and_slide()
	
	# шляпа без которой не работал реген работает каждый кадр
	if current_health < max_health:
		current_health += regen_amount_per_second * delta
		if current_health > max_health:
			current_health = max_health
		update_health_bar()

# получение по жопе
func take_damage(amount: float):
	if current_health <= 0:
		return  # сдох
	current_health -= amount
	update_health_bar()
	if current_health <= 0:
		die()

func _input(event):
	if event.is_action_pressed("ui_accept"):  # пробел
		take_damage(20)

# смерть 💀
func die():
	get_tree().change_scene_to_file("res://end_scene.tscn")
	# сюда анимку смерти
	queue_free()
