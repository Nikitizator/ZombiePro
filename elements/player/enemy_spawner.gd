extends Node2D

# Указываем путь к сцене врага (указал в инспекторе, ссылкой!)
@export var enemy_scene = preload("res://elements/player/enemy.tscn")
# Границы карты
@export var spawn_area_min : Vector2 = Vector2(0, 0)
@export var spawn_area_max : Vector2 = Vector2(400, 400)

# Настройки количества
@export var min_enemies : int = 5
@export var max_enemies : int = 10


func _ready() -> void:
	if Global.difficult == true:
		min_enemies = 30
		max_enemies = 60
		print("спавн")
		
	spawn_random_group(min_enemies, max_enemies)

func spawn_random_group(min, max):
	# Определяем случайное количество врагов
	var count = randi_range(min, max)
	for i in range(count):
		spawn_enemy()
func spawn_enemy():
	# Создаем экземпляр врага
	var enemy = enemy_scene.instantiate()
	
	# Выбираем случайную позицию
	var random_x = randf_range(spawn_area_min.x, spawn_area_max.x)
	var random_y = randf_range(spawn_area_min.y, spawn_area_max.y)
	enemy.global_position = Vector2(random_x, random_y)
	
	# Добавляем врага в дерево сцен
	add_child.call_deferred(enemy)
	

	
