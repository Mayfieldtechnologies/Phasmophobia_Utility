extends Control

signal CreateRange
signal ClearRange
signal GetRadius

@export var selected_range_value = ""
@export var zIndex = 3

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
	"1m": 1,
	"2.5 (Yokai Hearing)": 2.5,
	"3 (Crucifix Lv 1)": 3,
	"4 (Crucifix Lv 2, Onryo Firelight)": 4,
	"4.5 (Crucifix 1 - Demon)": 4.5,
	"5 (Cruficix 3)": 5,
	"6 (Crucifix 2 - Demon)": 6,
	"7.5 (Cruficix 3 - Demon)": 7.5,
	"10 (Normal Hearing)": 10,
	"12 (Myling Footstep)": 12,
	"15 (Raiju Electronic Hearing)": 15	
}

var range_radius = 0
var range_multiply = 3

func get_selected_range_value():
	var selected_range_index = RangeDropdown.selected
	selected_range_value = RangeDropdown.get_item_text(selected_range_index)
	#return selected_range_value

func load_range():
	
	#var distToLoad = dictScene[selected_range_value]
	#var sceneRange = load(distToLoad)
	#var instRange = sceneRange.instantiate()
	
	var instRange = blankCircle.instantiate()
	RangeCircles.add_child(instRange)
	
	instRange.global_position = Vector2(800,400)
	
	instRange.modulate = RangeColor.color
	instRange.modulate.a = 0.5
	instRange.z_index = zIndex
	zIndex += 1
	range_multiply = distMultiplier[selected_range_value]
	instRange.set_circle_properties(range_radius * range_multiply, RangeColor.color)


func _on_range_create_pressed():
	#emit_signal("CreateRange")
	get_selected_range_value()
	load_range()

func clear_ranges():
	for circle in get_tree().get_nodes_in_group("Circle"):
		circle.queue_free()

func _on_range_clear_pressed():
	clear_ranges()
	
func set_radius(r):
	range_radius = r
