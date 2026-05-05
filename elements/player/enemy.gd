extends CharacterBody2D

@export var speed : float = 80.0
@export var acceleration : float = 400.0
@export var detection_radius : float = 1024.0

var player : Node2D = null
var is_chasing : bool = false


func _ready():
	print(player)
	var found = get_tree().get_nodes_in_group("player")
	if found.size() > 0:
		player = found[0]


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


func _chase(delta):
	var direction = (player.global_position - global_position).normalized()
	velocity = velocity.move_toward(direction * speed, acceleration * delta)
	_update_facing(direction)


func _idle(delta):
	velocity = velocity.move_toward(Vector2.ZERO, acceleration * delta)


func _update_facing(direction: Vector2):
	if direction.x != 0:
		# Используем abs, чтобы не сбить масштаб, если он изначально не 1
		scale.x = abs(scale.x) * sign(direction.x)
