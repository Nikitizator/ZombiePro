extends Node

var difficult = 5

func set_difficulty(is_pressed: bool):
	if is_pressed:
		difficult = 10
	


func _on_check_button_toggled(toggled_on):
	# Вызываем функцию из глобального скрипта и передаем состояние
	Global.set_difficulty(toggled_on)
