extends Node2D

var zoom_factor = 1.0
var min_zoom = 0.5
var max_zoom = 10.0
var dragging = false
var drag_start = Vector2()
var currently_dragging = false
var panning = false

@onready var house_container = $house_container

signal set_zoom_string(zoom)

@onready var MapRangeCircles = $%RangeCircles
@onready var house_layer = $%HouseLayer
@onready var nodeHouse = $%House
@onready var nodeRooms = $%Rooms
@onready var nodeNames = $%Names
@onready var nodeGrid = $%Grid
@onready var nodePOI = $%POI
@onready var safe_spots = $%SafeSpots

@onready var node1mLeft = $%m_left
@onready var node1mRight = $%m_right


@onready var button_mapping = {
	"house": nodeHouse,
	"rooms": nodeRooms,
	"names": nodeNames,
	"grid": nodeGrid,
	"legend": nodePOI,
	"safe_spots": safe_spots
}



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
	"Point Hope Lighthouse": {
		"default_scale": .40,
		"xOffset": 312,
		"yOffset":248
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

var map_fresh_pan = true
var start_mouse_position = Vector2()

signal mapToggle

var blankCircle = preload("res://Scenes/Distance_Scenes/BlankCircle.tscn")
	
	
func _ready():
	set_process_input(true)

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

# This ended up not working.  I want to figure out why, so I don't have to deal with the above shit.
func toggle_layer(layer_name: String):
	print("House Layer Received: " + layer_name)
	button_mapping[layer_name].visible != button_mapping[layer_name].visible
	
func get_1m_distance():
	return mDistance


###########
# Dev Note: 01-09-24
# I am trying to figure out how to have it zoom on the mouse position
# because zooming from (0,0) blows
###########

func update_zoom(mouse_position, old_zoom):
	var offset = mouse_position - house_container.global_position
	offset /= old_zoom
	
	house_container.scale = Vector2(zoom_factor,zoom_factor)
	
	offset *= zoom_factor
	house_container.global_position = mouse_position - offset

func zoom_in():
	#if self.scale.x < 5:
		#self.scale += Vector2(zoom_scale,zoom_scale)
	#update_zoom_string()	
	
	var old_zoom = zoom_factor
	zoom_factor = clamp(zoom_factor * 1.1, min_zoom, max_zoom)
	update_zoom(get_global_mouse_position(),old_zoom)
	update_zoom_string()

	
func zoom_out():
	#if self.scale.x > 0.1:
		#self.scale -= Vector2(zoom_scale,zoom_scale)
	#update_zoom_string()
	
	var old_zoom = zoom_factor
	zoom_factor = clamp(zoom_factor * 0.9, min_zoom, max_zoom)
	update_zoom(get_global_mouse_position(),old_zoom)
	update_zoom_string()
	
	
func update_zoom_string():
	set_zoom_string.emit(snapped(house_container.scale.x,0.01))

func pan_map():
	#if map_fresh_pan:
		#panning = true
		#map_fresh_pan = false
		#start_mouse_position = get_global_mouse_position()
		
	#if panning:
		#var delta = start_mouse_position - get_global_mouse_position()
		#self.global_position -= delta
		##house_layer.global_position -= delta
		#start_mouse_position = get_global_mouse_position()
		
	if panning:
		var delta = drag_start - get_global_mouse_position()
		house_container.global_position -= delta
		drag_start = get_global_mouse_position()
	elif !panning:
		panning = true
		drag_start = get_global_mouse_position()
		

func stop_panning():
	panning = false
	#map_fresh_pan = true

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
	if(house != "Training Warehouse"):
		safe_spots.texture = load("res://Maps/Fantismal/"+ house + "/Safe_Spots.png")
	else:
		safe_spots.texture = null

func set_default_properties(house):
	set_graphics(house)
	update_zoom_string()
	#set_default_offset(house)
	#set_default_scale(house)
