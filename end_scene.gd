extends CanvasLayer


func _on_main_menu():
	get_tree().change_scene_to_file("res://main_menu.tscn")

func _on_restart():
	get_tree().change_scene_to_file("res://game.tscn")
