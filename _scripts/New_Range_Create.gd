extends Control


@export var selected_range_value = ""
@export var zIndex = 3

@onready var RangeDropdown = get_node("/root/Main/RangeSelect/RangeDropdown")
@onready var RangeCircles = get_node("/root/Main/RangeLayer/RangeCircles")
@onready var RangeColor = get_node("/root/Main/RangeSelect/RangeColor")

@onready var dictScene = {
	"1": "res://Scenes/Distance_Scenes/1m.tscn",
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


func _on_pressed():
	var selected_range_index = RangeDropdown.selected
	selected_range_value = RangeDropdown.get_item_text(selected_range_index)
		
	LoadRange()

func LoadRange():
	
	var distToLoad = dictScene[selected_range_value]
	var sceneRange = load(distToLoad)
	var instRange = sceneRange.instantiate()
	
	RangeCircles.add_child(instRange)
	
	instRange.global_position = Vector2(800,400)
	
	instRange.modulate = RangeColor.color
	instRange.modulate.a = 0.5
	instRange.z_index = zIndex
	zIndex += 1
