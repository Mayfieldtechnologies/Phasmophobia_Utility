extends Button

#@onready var button_off = preload("res://Scenes/UI_Scenes/Resources/smudge_timer_off.tres")
@onready var button_off = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_timer_off.tres")
@onready var button_on = preload("res://Scenes/UI_Scenes/Resources/Smudge/smudge_timer_on.tres")

# Called when the node enters the scene tree for the first time.
func _ready():
	#add_theme_stylebox_override("normal",button_off)
	pass # Replace with function body.

func toggle_theme_override(timer_state):
	# timer_state is the state of the timer.  If true, then the timer is active
	if timer_state:
		add_theme_stylebox_override("normal",button_on)
	else:
		add_theme_stylebox_override("normal",button_off)
		
func toggle_button_state(timer_state):
	if timer_state:
		add_theme_stylebox_override("normal",button_on)
		add_theme_stylebox_override("hover",button_on)
		add_theme_stylebox_override("focus",button_on)
		self.text = "Stop Timer"
	else:
		add_theme_stylebox_override("normal",button_off)
		add_theme_stylebox_override("hover",button_off)
		add_theme_stylebox_override("focus",button_off)
		self.text = "Start Timer"

func _input(event):
	if event is InputEventKey:
		var key_event = event as InputEventKey
		print("Scancode:" + str(key_event.get_keycode_with_modifiers()))
		if key_event.pressed:
			if key_event.get_keycode_with_modifiers() == 91:
				self.emit_signal("pressed")
