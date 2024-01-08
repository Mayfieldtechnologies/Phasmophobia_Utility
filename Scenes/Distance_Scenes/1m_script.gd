extends Node2D

signal get_radius

var selected = false

var currPosition
var mousePosition

var mRadius
var rColor

var bool_draw = true

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_just_pressed("Click"):
		selected = true

func _physics_process(delta):
	currPosition = global_position
	mousePosition = get_global_mouse_position()
	
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(),25*delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
	
func _draw():
	if bool_draw:
		draw_circle(Vector2.ZERO,mRadius,rColor)
	
func set_radius(radius):
	mRadius = radius
	
func toggle_draw():
	bool_draw != bool_draw
	
func set_circle_properties(radius, color):
	mRadius = radius
	rColor = color
