extends Area2D


@export var speed: float = 600.0 
@export var damage: int = 25     

func _physics_process(delta):
	position += transform.x * speed * delta
	
	#проверка пересекающихся
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.is_in_group("player"): #проверка чтобы не застрелить себя
			continue
			
		if body.has_method("take_damage"): #проверка наличия функции получения урона
			body.take_damage(damage)
			queue_free()

func _delete_bullet():
	queue_free()
