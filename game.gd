extends Node2D

var pause_game : bool = false
var menu = null

func _on_timer():
	var all_children = $EnemySpawner.get_children()
	print(all_children)
	if len(all_children) == 0:
		get_tree().change_scene_to_file("res://win_scene.tscn")

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		if not pause_game:
			pause()
		else:
			unpause()

func pause():
	pause_game = true 
	get_tree().paused = true
	menu = preload("res://pause_scene.tscn").instantiate()
	add_child(menu)

func unpause():
	pause_game = false
	get_tree().paused = false
	if menu:
		menu.queue_free()
		menu = null
