extends Node2D

signal get_radius

var selected = false

var currPosition
var mousePosition

var mRadius
var rColor

var bool_draw = true
var fresh_pan = true
var panning = false
var start_mouse_position
var zoom_scale = 0.1

func _on_area_2d_input_event(_viewport, _event, _shape_idx):
	if Input.is_action_pressed("Click"):
		pan_map()
	elif Input.is_action_just_released("Click"):
		stop_panning()

func _process(delta):
	currPosition = global_position
	mousePosition = get_global_mouse_position()
	

	if Input.is_action_pressed("Pan_Map"):
		#pan_map()
		pass
	elif Input.is_action_just_released("Pan_Map"):
		#stop_panning()
		pass
		

	
func pan_map():
	if fresh_pan:
		panning = true
		fresh_pan = false
		start_mouse_position = get_global_mouse_position()
		#print("fresh start_mouse_position:" + str(start_mouse_position))
		
	if panning:
		var delta = start_mouse_position - get_global_mouse_position()
		self.global_position -= delta
		start_mouse_position = get_global_mouse_position()
		#print("new start_mouse_position:" + str(start_mouse_position))
	
func stop_panning():
	panning = false
	fresh_pan = true
	print("Ready for fresh pan")

'''
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			print(event)
		if event.button_index == MOUSE_BUTTON_MIDDLE and not event.pressed:
			selected = false
			print()
			
	print(event)
'''

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

func zoom_in():
	self.scale += Vector2(zoom_scale,zoom_scale)

func zoom_out():
	self.scale -= Vector2(zoom_scale,zoom_scale)
