extends Node2D

var pause_game : bool = false
var menu = null

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not pause_game: # Если еще не на паузе
			pause()
		else: # Если уже на паузе
			unpause()

func pause():
	pause_game = true  # ЗАПОМНИЛИ, что пауза включена
	get_tree().paused = true
	menu = preload("res://pause_scene.tscn").instantiate()
	add_child(menu)

func unpause():
	pause_game = false # ЗАПОМНИЛИ, что пауза выключена
	get_tree().paused = false
	if menu:
		menu.queue_free()
		menu = null # Очищаем переменную для порядка
