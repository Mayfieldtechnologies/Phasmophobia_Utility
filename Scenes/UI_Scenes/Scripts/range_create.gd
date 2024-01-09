extends Control

signal CreateRange(radius,color)
signal ClearRange
signal GetRadius

@export var selected_range_value = ""
@export var zIndex = 1

@onready var RangeDropdown = $RangeDropdown
@onready var RangeCircles = $RangeCircles
@onready var RangeColor = $RangeColor

var blankCircle = preload("res://Scenes/Distance_Scenes/1m.tscn")

@onready var dictScene = {
	"1m": "res://Scenes/Distance_Scenes/1m.tscn",
	"2.5 (Yokai Hearing)": "res://Scenes/Distance_Scenes/2.5m.tscn",
	"3 (Crucifix Lv 1)": "res://Scenes/Distance_Scenes/3m.tscn",
	"4 (Crucifix Lv 2, Onryo Firelight)": "res://Scenes/Distance_Scenes/4m.tscn",
	"4.5 (Crucifix 1 - Demon)": "res://Scenes/Distance_Scenes/4_5m.tscn",
	"5 (Cruficix 3)": "res://Scenes/Distance_Scenes/5m.tscn",
	"6 (Crucifix 2 - Demon)": "res://Scenes/Distance_Scenes/6m.tscn",
	"7.5 (Cruficix 3 - Demon)": "res://Scenes/Distance_Scenes/7_5m.tscn",
	"10 (Normal Hearing)": "res://Scenes/Distance_Scenes/10m.tscn",
	"12 (Myling Footstep)": "res://Scenes/Distance_Scenes/12m.tscn",
	"15 (Raiju Electronic Hearing)": "res://Scenes/Distance_Scenes/15m.tscn"	
}

@onready var dictScene_2 = {
	"1": {
		"Color": "red",
		"Scene": "res://Scenes/Distance_Scenes/1m.tscn"
	}
	
}

@onready var distMultiplier = {
	"1m": {
		"Multiplier": 1,
		"DefaultColor": Color.BLACK
	},
	"2.5m (Yokai Hearing)": {
		"Multiplier": 2.5,
		"DefaultColor": Color.AQUA
	},
	"3m (Crucifix Lv 1)": {
		"Multiplier": 3,
		"DefaultColor": Color.SANDY_BROWN
	},
	"4m (Crucifix Lv 2, Onryo Firelight)": {
		"Multiplier": 4,
		"DefaultColor": Color.DARK_ORANGE
	},
	"4.5m (Crucifix 1 - Demon)": {
		"Multiplier": 4.5,
		"DefaultColor": Color.SADDLE_BROWN
	},
	"5m (Cruficix 3)": {
		"Multiplier": 5,
		"DefaultColor": Color.SEA_GREEN
	},
	"6m (Crucifix 2 - Demon)": {
		"Multiplier": 6,
		"DefaultColor": Color.ORANGE_RED
	},
	"7.5m (Cruficix 3 - Demon)": {
		"Multiplier": 7.5,
		"DefaultColor": Color.DARK_GREEN
	},
	"10m (Normal Hearing)": {
		"Multiplier": 10,
		"DefaultColor": Color.DIM_GRAY
	},
	"12m (Myling Footstep)": {
		"Multiplier": 12,
		"DefaultColor": Color.CADET_BLUE
	},
	"15m (Raiju Electronic Hearing)": {
		"Multiplier": 15,
		"DefaultColor": Color.YELLOW
	}	
}

var range_radius = 1
#var range_multiply = 99

var global_scale = 1

var new_method = true

func get_selected_range_value():
	var selected_range_index = RangeDropdown.selected
	selected_range_value = RangeDropdown.get_item_text(selected_range_index)
	#return selected_range_value

func _on_range_create_pressed():
	if(!new_method):
		#load_range()
		pass
	else:
		new_load_range()
	


func new_load_range():
	get_selected_range_value()
	var range_multiply
	var default_color
	
	range_multiply = distMultiplier[selected_range_value]["Multiplier"]
	
	emit_signal("CreateRange",range_multiply,RangeColor.color)
	print("Range Create Button Pressed.  Radius: " + str(range_multiply) + "Color: " + str(RangeColor.color))

'''
func load_range():	
	get_selected_range_value()
	get_radius()
	
	var instRange = blankCircle.instantiate()
	#instRange.scale = Vector2(global_scale,global_scale)
	
	RangeCircles.add_child(instRange)
	
	instRange.global_position = Vector2(800,400)
	
	instRange.modulate = RangeColor.color
	instRange.modulate.a = 0.5
	instRange.z_index = zIndex
	zIndex += 1
	
	range_multiply = distMultiplier[selected_range_value]
	range_radius *= range_multiply
	print("circle property rangge: " + str(range_radius))
	instRange.set_circle_properties(range_radius, RangeColor.color)
'''

func clear_ranges():
	for circle in get_tree().get_nodes_in_group("Circle"):
		circle.queue_free()

func _on_range_clear_pressed():
	clear_ranges()
	
func set_radius(r):
	range_radius = r
	#pass

func get_radius():
	emit_signal("GetRadius")


func _on_range_dropdown_item_selected(index):
	get_selected_range_value()
	var default_color
	default_color = distMultiplier[selected_range_value]["DefaultColor"]
	RangeColor.color = default_color
