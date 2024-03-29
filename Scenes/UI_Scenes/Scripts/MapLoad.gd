extends Control

@export var selected_map_value = ""
@export var zIndex = 1
@onready var MapDropdown = get_node("/root/Main/MapSelect/MapDropdownButton")
@onready var CurrMap = get_node("/root/Main/Current/Map")
@onready var locMapSpawn = get_node("/root/Main/locMapSpawn/locMapSpawnPointRight")

func _on_pressed():
	var selected_map_index = MapDropdown.selected
	selected_map_value = MapDropdown.get_item_text(selected_map_index)
	
	LoadMap()

func LoadMap():
	var sceneMap = load("res://Scenes/Map_Scenes/" + selected_map_value.replace(" ","") +".tscn")
	var instMap = sceneMap.instantiate()
	
	CurrMap.add_child(instMap)
	instMap.global_position = locMapSpawn.global_position
	instMap.z_index = zIndex
