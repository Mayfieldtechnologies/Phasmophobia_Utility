extends Node2D

signal set_zoom_string(zoom)

@onready var MapRangeCircles = $RangeCircles
@onready var house_layer = $HouseLayer
@onready var nodeHouse = $HouseLayer/House
@onready var nodeRooms = $HouseLayer/Rooms
@onready var nodeNames = $HouseLayer/Names
@onready var nodeGrid = $HouseLayer/Grid
@onready var nodePOI = $HouseLayer/POI
@onready var node1mLeft = $HouseLayer/m_left
@onready var node1mRight = $HouseLayer/m_right
@onready var safe_spots = $HouseLayer/SafeSpots


@onready var house_properties = {
	"6 Tanglewood": {
		"default_scale": 1,
		"xOffset": -30,
		"yOffset": 0
	},
	"10 Ridgeview Ct": {
		"default_scale": 0.55,
		"xOffset": 215,
		"yOffset": 177
	},
	"13 Willow St": {
		"default_scale": 0.9,
		"xOffset": 36,
		"yOffset": 36
	},
	"42 Edgefield Rd": {
		"default_scale": 0.55,
		"xOffset": 215,
		"yOffset": 177
	},
	"Bleasdale Farmhouse": {
		"default_scale": 0.6,
		"xOffset": 215,
		"yOffset": 177
	},
	"Brownstone High School": {
		"default_scale": 0.20,
		"xOffset": 423,
		"yOffset": 317
	},
	"Camp Woodwind": {
		"default_scale": .95,
		"xOffset": -30,
		"yOffset": 14
	},
	"Grafton Farmhouse": {
		"default_scale": 0.7,
		"xOffset": 146,
		"yOffset": 115
	},
	"Maple Lodge Campsite": {
		"default_scale": .55,
		"xOffset": 212,
		"yOffset": 198
	},
	"Prison": {
		"default_scale": .3,
		"xOffset": 393,
		"yOffset": 258
	},
	"Sunny Meadows": {
		"default_scale": .3,
		"xOffset": 410,
		"yOffset": 281
	},
	"Training Warehouse": {
		"default_scale": .6,
		"xOffset": 231,
		"yOffset": 181
	}
}

@export var zoom_scale = 0.05

var mDistance

var panning = false
var map_fresh_pan = true
var start_mouse_position = Vector2()

signal mapToggle

var blankCircle = preload("res://Scenes/Distance_Scenes/BlankCircle.tscn")
	
func update_1m_measurement():
	mDistance = node1mRight.global_position.x - node1mLeft.global_position.x
	print("1m Pixel Distamce = " + str(mDistance))
	return mDistance


func toggle_house():
	nodeHouse.visible = !nodeHouse.visible
	
func toggle_boundaries():
	nodeRooms.visible = !nodeRooms.visible
	
func toggle_names():
	nodeNames.visible = !nodeNames.visible

func toggle_grid():
	nodeGrid.visible = !nodeGrid.visible
	
func toggle_legend():
	nodePOI.visible = !nodePOI.visible

func toggle_safe_spots():
	safe_spots.visible = !safe_spots.visible

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
	update_zoom_string()	
	
	#start_mouse_position = get_global_mouse_position()
	#var mouse_offset = start_mouse_position - self.position
	#self.position -= mouse_offset * (zoom_scale -1.0)
	#self.position = start_mouse_position - (start_mouse_position - self.position) * zoom_scale
	
func zoom_out():
	if self.scale.x > 0.1:
		self.scale -= Vector2(zoom_scale,zoom_scale)
	update_zoom_string()
	
	#start_mouse_position = get_global_mouse_position()
	#var mouse_offset = start_mouse_position - self.position
	#self.position -= mouse_offset * (zoom_scale -1.0)
	#self.position = start_mouse_position - (start_mouse_position - self.position) * zoom_scale
	
func update_zoom_string():
	set_zoom_string.emit(snapped(self.scale.x,0.01))

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
	
	instRange.global_position = Vector2(500,500)
	instRange.modulate = color
	instRange.modulate.a = 0.5
	
	instRange.set_circle_properties(range_radius, color)


func set_default_scale(house):
	self.scale = Vector2(house_properties[house]["default_scale"],house_properties[house]["default_scale"])
	print(self.scale)

func get_default_scale(house):
	return house_properties[house]["default_scale"]

func get_x_offset(house):
	var xOffset = house_properties[house]["xOffset"]
	return xOffset
	
func get_y_offset(house):
	var yOffset = house_properties[house]["yOffset"]
	return yOffset
	
func set_default_offset(house):
	house_layer.position += Vector2(get_x_offset(house),get_y_offset(house))
	
func set_graphics(house):
	nodeHouse.texture = load("res://Maps/Fantismal/"+ house + "/House.png")
	nodeRooms.texture = load("res://Maps/Fantismal/"+ house + "/Rooms.png")
	nodeGrid.texture = load("res://Maps/Fantismal/"+ house + "/Grid.png")
	nodePOI.texture = load("res://Maps/Fantismal/"+ house + "/POI.png")
	nodeNames.texture = load("res://Maps/Fantismal/"+ house + "/Names.png")
	if(house == "13 Willow St" || house == "6 Tanglewood"):
		safe_spots.texture = load("res://Maps/Fantismal/"+ house + "/Safe_Spots.png")
	else:
		safe_spots.texture = null

func set_default_properties(house):
	set_graphics(house)
	update_zoom_string()
	#set_default_offset(house)
	#set_default_scale(house)
