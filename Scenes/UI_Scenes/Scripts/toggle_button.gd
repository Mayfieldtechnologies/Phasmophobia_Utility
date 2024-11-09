extends Button

@export var can_toggle: bool = false

@export var default_text: String

@export var normal_theme: StyleBoxFlat
@export var hover_theme: StyleBoxFlat
@export var pressed_theme: StyleBoxFlat
@export var disabled_theme: StyleBoxFlat
@export var focus_theme: StyleBoxFlat

@export var toggled_normal_theme: StyleBoxFlat
@export var toggled_hover_theme: StyleBoxFlat
@export var toggled_pressed_theme: StyleBoxFlat
@export var toggled_disabled_theme: StyleBoxFlat
@export var toggled_focus_theme: StyleBoxFlat

signal state_toggled(toggle_state: bool)

func _ready():
	#self.text = default_text
	
	# Set toggled themes to normal themes if no resource is assigned
	if toggled_normal_theme == null:
		toggled_normal_theme = normal_theme
	if toggled_hover_theme == null:
		toggled_hover_theme = hover_theme
	if toggled_pressed_theme == null:
		toggled_pressed_theme = pressed_theme
	if toggled_disabled_theme == null:
		toggled_disabled_theme = disabled_theme
	if toggled_focus_theme == null:
		toggled_focus_theme = focus_theme
		
	toggle_state(false)
	
func toggle_state(toggled_on: bool):
	print("toggled:" + self.text + " = " + str(toggled_on))
	emit_signal("state_toggled",toggled_on)
	if !can_toggle:
		button_pressed = false
		
	if toggled_on && can_toggle:
		add_theme_stylebox_override("normal",toggled_normal_theme)
		add_theme_stylebox_override("hover",toggled_normal_theme)
		add_theme_stylebox_override("pressed",toggled_normal_theme)
		add_theme_stylebox_override("disabled",toggled_normal_theme)
		add_theme_stylebox_override("focus",toggled_normal_theme)
	else:
		add_theme_stylebox_override("normal",normal_theme)
		add_theme_stylebox_override("hover",normal_theme)
		add_theme_stylebox_override("pressed",normal_theme)
		add_theme_stylebox_override("disabled",normal_theme)
		add_theme_stylebox_override("focus",normal_theme)

func set_can_toggle(val: bool):
	can_toggle = val
	if !can_toggle:
		button_pressed = false

# Don't use this function yet.... maybe...
func coalesce(a: StyleBoxFlat,b: StyleBoxFlat):
	if a == null:
		a = b
