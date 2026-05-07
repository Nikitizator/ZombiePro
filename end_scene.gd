extends Button

func _on_main_menu():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_restart():
	get_tree().change_scene_to_file("res://game.tscn")
	
func _for_pause_main_menu():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _for_pause_restart():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://game.tscn")
