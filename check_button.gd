extends CheckButton

var difficult = 5

func _on_button():
	print(button_pressed)
	if button_pressed:
		var difficult = 10
		print(difficult)
		return
	return
	
