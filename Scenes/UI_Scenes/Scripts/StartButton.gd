extends Button


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		print("Scancode:" + str(key_event.get_keycode_with_modifiers()))
		if key_event.pressed:
			if key_event.get_keycode_with_modifiers() == 91:
				self.emit_signal("pressed")
