extends Area2D


@export var speed: float = 600.0 # Скорость полета
@export var damage: int = 25     # Урон, который наносит пуля

func _physics_process(delta):
	position += transform.x * speed * delta
	
	# Прямая проверка: какие тела сейчас перекрывают пулю?
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"): # чтобы не застрелить самого себя
			continue
			
		if body.has_method("take_damage"):
			body.take_damage(damage)
			queue_free()

func _on_body_entered(body):	
	# Проверяем, есть ли у того, в кого мы попали, метод получения урона
	if body.has_method("take_damage"):
		body.take_damage(damage) # Наносим урон
	# Пуля уничтожается при столкновении с любым объектом (стена, враг и т.д.)
	queue_free()

func _on_visible_on_screen_notifier_2d_screen_exited():

	queue_free()# Удаляем пулю, если она улетела за экран, чтобы не засорять память
