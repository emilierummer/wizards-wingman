extends PanelContainer

signal play_pressed

func _on_start_button_pressed():
	play_pressed.emit()
