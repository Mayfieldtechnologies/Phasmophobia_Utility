extends Node2D

@onready var MapRangeCircles = $RangeCircles
@onready var house_layer = $HouseLayer
@onready var nodeHouse = $HouseLayer/House
@onready var nodeBoundaries = $HouseLayer/Boundaries
@onready var nodeNames = $HouseLayer/Names
@onready var nodeGrid = $HouseLayer/Grid
@onready var nodeLegend = $HouseLayer/Legend
@onready var node1mLeft = $HouseLayer/m_left
@onready var node1mRight = $HouseLayer/m_right

@onready var house_properties = {
	"6 Tanglewood": {
		"default_scale": 1,
		"xOffset": -30,
		"yOffset": 0
	}
}

@export var zoom_scale = 0.1

var mDistance

var panning = false
var map_fresh_pan = true
var start_mouse_position = Vector2()

signal mapToggle

var blankCircle = preload("res://Scenes/Distance_Scenes/1m.tscn")
	
func update_1m_measurement():
	mDistance = node1mRight.global_position.x - node1mLeft.global_position.x
	print("1m Pixel Distamce = " + str(mDistance))
	return mDistance


func toggle_house():
	nodeHouse.visible = !nodeHouse.visible
	
func toggle_boundaries():
	nodeBoundaries.visible = !nodeBoundaries.visible
	
func toggle_names():
	nodeNames.visible = !nodeNames.visible

func toggle_grid():
	nodeGrid.visible = !nodeGrid.visible
	
func toggle_legend():
	nodeLegend.visible = !nodeLegend.visible

func get_1m_distance():
	return mDistance


###########
# Dev Note: 01-09-24
# I am trying to figure out how to have it zoom on the mouse position
# because zooming from (0,0) blows
###########

func zoom_in():
	if self.scale.x < 5:
		self.scale += Vector2(zoom_scale,zoom_scale)

	#start_mouse_position = get_global_mouse_position()
	#var mouse_offset = start_mouse_position - self.position
	#self.position -= mouse_offset * (zoom_scale -1.0)
	#self.position = start_mouse_position - (start_mouse_position - self.position) * zoom_scale
	
func zoom_out():
	if self.scale.x > 0.1:
		self.scale -= Vector2(zoom_scale,zoom_scale)
	#start_mouse_position = get_global_mouse_position()
	#var mouse_offset = start_mouse_position - self.position
	#self.position -= mouse_offset * (zoom_scale -1.0)
	#self.position = start_mouse_position - (start_mouse_position - self.position) * zoom_scale
	
func pan_map():
	if map_fresh_pan:
		panning = true
		map_fresh_pan = false
		start_mouse_position = get_global_mouse_position()
		
	if panning:
		var delta = start_mouse_position - get_global_mouse_position()
		self.global_position -= delta
		#house_layer.global_position -= delta
		start_mouse_position = get_global_mouse_position()

func stop_panning():
	panning = false
	map_fresh_pan = true

func create_range(range_radius,color):
	var instRange = blankCircle.instantiate()
	MapRangeCircles.add_child(instRange)
	
	instRange.position = Vector2(500,500)
	instRange.modulate = color
	instRange.modulate.a = 0.5
	
	instRange.set_circle_properties(range_radius, color)

func set_default_scale(house):
	self.scale = Vector2(house_properties[house]["default_scale"],house_properties[house]["default_scale"])

func get_x_offset(house):
	var xOffset = house_properties[house]["xOffset"]
	return xOffset
	
func get_y_offset(house):
	var yOffset = house_properties[house]["yOffset"]
	return yOffset
