extends CharacterBody2D
#Скорость, ускорение, радиус детекции 
@export var speed : float = 80.0
@export var acceleration : float = 400.0
@export var detection_radius : float = 1040.0

#ХП, текущее хп, реген и експорт хилбара как узла(для изменения его значений)
@export var max_health : float = 100.0
var current_health : float
@export var regen_amount_per_second : float = 1.0  # хп за 1 секунду
@onready var health_bar = $healthbar

@export var damage : float = 10.0

var player : Node2D = null
var is_chasing : bool = false

#Приравниваем хп и находим игрока на карте(через группу)
func _ready():
	current_health = max_health
	var found = get_tree().get_nodes_in_group("player")
	if found.size() > 0:
		player = found[0]

#Проверяем дистанцию до врага и сравниваем ее с радиусом детекции
func _physics_process(delta):
	if not player:
		return

	var distance = global_position.distance_to(player.global_position)

	if distance <= detection_radius:
		is_chasing = true

	if is_chasing:
		_chase(delta)
	else:
		_idle(delta)

	move_and_slide()
	
	if current_health < max_health:
		current_health += regen_amount_per_second * delta
		if current_health > max_health:
			current_health = max_health
		update_health_bar()
		

func _on_attack_area_body_entered(body):
	
	if body != self and body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)
	
	if body.is_in_group("player"):
		if body.has_method("take_damage"):
			body.take_damage(damage)

func _chase(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	_update_facing(direction)


func _idle(delta):
	velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)


func _update_facing(direction: Vector2):
	if direction.x != 0:
		scale.x = abs(scale.x) * sign(direction.x)


func update_health_bar():
	if health_bar:
		health_bar.value = current_health
		var progress_style = health_bar.get_theme_stylebox("progress")
		if progress_style and current_health < max_health * 0.3:
			progress_style.bg_color = Color(1, 0, 0)
		elif progress_style:
			progress_style.bg_color = Color(0, 1, 0)


func take_damage(amount: float):
	if current_health <= 0:
		return
	current_health -= amount
	update_health_bar()
	if current_health <= 0:
		die()


func die():
	queue_free()
	
