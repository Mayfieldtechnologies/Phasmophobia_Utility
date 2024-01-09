extends Control

signal close_how_to_use

func _on_button_pressed():
	emit_signal("close_how_to_use")
