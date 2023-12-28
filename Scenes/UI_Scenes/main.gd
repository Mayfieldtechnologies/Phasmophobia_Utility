extends Node2D

@onready var MapSelect = $MapSelect

var selected_map_value
@export var zIndex = 1
@onready var MapDropdown = $MapSelect/MapDropdownButton
@onready var CurrMap = $Current/Map
@onready var locMapSpawn = $locMapSpawn/locMapSpawnPointRight

# Called when the node enters the scene tree for the first time.
func _ready():
	MapSelect.loadMap.connect(LoadMap)

func LoadMap():
	var selected_map_index = MapDropdown.selected
	selected_map_value = MapDropdown.get_item_text(selected_map_index)
	
	var sceneMap = load("res://Scenes/Map_Scenes/" + selected_map_value.replace(" ","") +".tscn")
	var instMap = sceneMap.instantiate()
	
	CurrMap.add_child(instMap)
	instMap.global_position = locMapSpawn.global_position
	instMap.z_index = zIndex
