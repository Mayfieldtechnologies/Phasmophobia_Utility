extends Control

signal CreateRange(radius,color)
signal ClearRange
signal GetRadius

@export var selected_range_value = ""
@export var zIndex = 1

@onready var RangeDropdown = $RangeDropdown
@onready var RangeCircles = $RangeCircles
@onready var RangeColor = $RangeColor

var blankCircle = preload("res://Scenes/Distance_Scenes/BlankCircle.tscn")

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
		"Scene": "res://Scenes/Distance_Scenes/BlankCircle.tscn"
	}
	
}

@onready var distMultiplier = {
	"1m": {
		"Multiplier": 1.0,
		"DefaultColor": Color.BLACK
	},
	"Yokai Elec. Hearing - 2.5m": {
		"Multiplier": 2.5,
		"DefaultColor": Color.DARK_SLATE_BLUE
	},
	"Crucifix Lv 1 - 3.0m": {
		"Multiplier": 3.0,
		"DefaultColor": Color.SANDY_BROWN
	},
	"Crucifix Lv 2 - 4.0m": {
		"Multiplier": 4.0,
		"DefaultColor": Color.DARK_ORANGE
	},
	"Onryo Firelight Protection - 4.0m": {
		"Multiplier": 4.0,
		"DefaultColor": Color.DARK_ORANGE
	},
	"Crucifix Lv 1 (Demon) - 4.5m": {
		"Multiplier": 4.5,
		"DefaultColor": Color.SADDLE_BROWN
	},
	"Crucifix Lv 3 - 5.0m": {
		"Multiplier": 5.0,
		"DefaultColor": Color.SEA_GREEN
	},
	"Crucifix Lv 2 (Demon) - 6.0m": {
		"Multiplier": 6.0,
		"DefaultColor": Color.ORANGE_RED
	},
	"Crucifix Lv 3 (Demon) - 7.5m": {
		"Multiplier": 7.5,
		"DefaultColor": Color.DARK_GREEN
	},
	"Ghost Elec. Detection - 7.5m": {
		"Multiplier": 7.5,
		"DefaultColor": Color.DARK_GREEN
	},
	"Global Chat Detection - 9.0m": {
		"Multiplier": 9.0,
		"DefaultColor": Color.DARK_GREEN
	},
	"Elec. Interference Range - 10.0m": {
		"Multiplier": 10.0,
		"DefaultColor": Color.DIM_GRAY
	}, 
	"Myling Footstep Audible - 12.0m": {
		"Multiplier": 12.0,
		"DefaultColor": Color.CADET_BLUE
	},
	"Raiju Elec. Detection - 15.0m": {
		"Multiplier": 15.0,
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
		new_load_range()

func new_load_range():
	get_selected_range_value()
	var range_multiply
	var default_color
	
	range_multiply = distMultiplier[selected_range_value]["Multiplier"]
	
	emit_signal("CreateRange",range_multiply,RangeColor.color)
	#print("Range Create Button Pressed.  Radius: " + str(range_multiply) + "Color: " + str(RangeColor.color))

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
