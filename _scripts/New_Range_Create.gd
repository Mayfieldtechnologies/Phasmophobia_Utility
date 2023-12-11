extends Control


@export var selected_range_value = ""
@export var zIndex = 3

@onready var RangeDropdown = get_node("/root/Main/RangeSelect/RangeDropdown")
@onready var RangeCircles = get_node("/root/Main/Current/RangeCircles")
@onready var RangeColor = get_node("/root/Main/RangeSelect/RangeColor")

'''
@onready var scn1 = preload("res://Scenes/Distance_Scenes/1m.tscn")
@onready var scn2_5 = preload("res://Scenes/Distance_Scenes/2.5m.tscn")
@onready var scn3 = preload("res://Scenes/Distance_Scenes/3m.tscn")
@onready var scn4_5 = preload("res://Scenes/Distance_Scenes/4_5m.tscn")
@onready var scn5 = preload("res://Scenes/Distance_Scenes/5m.tscn")
@onready var scn6 = preload("res://Scenes/Distance_Scenes/6m.tscn")
@onready var scn7_5 = preload("res://Scenes/Distance_Scenes/7_5m.tscn")
@onready var scn10 = preload("res://Scenes/Distance_Scenes/10m.tscn")
@onready var scn12 = preload("res://Scenes/Distance_Scenes/12m.tscn")
@onready var scn15 = preload("res://Scenes/Distance_Scenes/15m.tscn")
'''

@onready var dictScene = {
	"1": "res://Scenes/Distance_Scenes/1m.tscn",
	"2.5": "res://Scenes/Distance_Scenes/2.5m.tscn",
	"3": "res://Scenes/Distance_Scenes/3m.tscn",
	"4": "res://Scenes/Distance_Scenes/4m.tscn",
	"4.5": "res://Scenes/Distance_Scenes/4_5m.tscn",
	"5": "res://Scenes/Distance_Scenes/5m.tscn",
	"6": "res://Scenes/Distance_Scenes/6m.tscn",
	"7.5": "res://Scenes/Distance_Scenes/7_5m.tscn",
	"10": "res://Scenes/Distance_Scenes/10m.tscn",
	"12": "res://Scenes/Distance_Scenes/12m.tscn",
	"15": "res://Scenes/Distance_Scenes/15m.tscn"	
}



func _on_pressed():
	var selected_range_index = RangeDropdown.selected
	selected_range_value = float(RangeDropdown.get_item_text(selected_range_index))
		
	LoadRange()

func LoadRange():
	#var sceneRange = load("res://Scenes/Distance_Scenes/1m.tscn")
	var distToLoad = dictScene[str(selected_range_value)]
	var sceneRange = load(distToLoad)
	var instRange = sceneRange.instantiate()
	
	RangeCircles.add_child(instRange)
	#instRange.global_scale = Vector2(selected_range_value*2,selected_range_value*2)
	instRange.global_position = Vector2(800,400)
	
	instRange.modulate = RangeColor.color
	instRange.modulate.a = 0.5
	instRange.z_index = zIndex
	zIndex += 1
