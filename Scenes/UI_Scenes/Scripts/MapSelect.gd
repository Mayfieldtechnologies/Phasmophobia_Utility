extends Control

signal loadMap
signal clearMap

@export var selected_map_value = ""
@export var zIndex = 1
@onready var MapDropdown = $MapDropdown

var map_folder = ""
#@onready var CurrMap = get_node("/root/Main/Current/Map")
#@onready var locMapSpawn = get_node("/root/Main/locMapSpawn/locMapSpawnPointRight")

func _on_pressed():
	LoadMap()

func LoadMap():
	get_selected_map()
	get_map_folder(selected_map_value)
		
	var sceneMap = load("res://Scenes/Fantismal Maps/House.tscn")
	var instMap = sceneMap.instantiate()
	

func get_selected_map():
	var selection_index = MapDropdown.selected
	selected_map_value = MapDropdown.get_item_text(selection_index)
	return selected_map_value

func get_map_folder(map_name):
	map_folder =  "res://Maps/Fantismal/"+map_name+"/"
	return map_folder

func _on_map_load_pressed():
	emit_signal("loadMap")

func _on_range_clear_pressed():
	emit_signal("clearMap")

func reset_dropdown():
	MapDropdown.selected = -1
