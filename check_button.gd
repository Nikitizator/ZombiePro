#Скрипт чтобы менять уровень сложности
extends Node

var difficult = false

func set_difficulty(is_pressed: bool):
	if is_pressed:
		difficult = true

func _on_check_button_toggled(toggled_on):
	Global.set_difficulty(toggled_on)
