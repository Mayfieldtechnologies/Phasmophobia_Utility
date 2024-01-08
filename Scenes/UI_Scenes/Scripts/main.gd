extends Node2D

############################
# BEGIN GLOBAL DECLARATION #
############################

# UI Scenes
@onready var ui_layer = $UILayer
@onready var SmudgeTimer = $UILayer/CountdownTimer
@onready var MapSelect = $UILayer/MapSelect
@onready var RangeCreate = $UILayer/RangeCreate
@onready var option_button = $UILayer/option_button

# CountdownTimer's Audio
@onready var TimerAudio = $UILayer/CountdownTimer/TimerAudio

# Map Scenes
@onready var MapDropdown = $UILayer/MapSelect/MapDropdown
@onready var current_map = $MapLayer/current_map

# Options Scene
@onready var options_scene = preload("res://Scenes/UI_Scenes/options.tscn")

# Map Layer Togglesd
@onready var toggle_house = $MapOptionButtons/toggleHouse
@onready var toggle_grid = $MapOptionButtons/toggleGrid
@onready var toggle_boundaries = $MapOptionButtons/toggleBoundaries
@onready var toggle_legend = $MapOptionButtons/toggleLegend

# Instantiated Scenes
var instMap
var options_ui

# Configuration Variables
var bypass_smudge_pause = false
var mirror_ui = false
var anchor_node = "normal"
var master_volume = 0
var slider_value = 50

var range_radius = 0

##########################
# END GLOBAL DELCARATION #
##########################

# Called when the node enters the scene tree for the first time.
func _ready():
	MapSelect.loadMap.connect(_load_map_button_pressed)
	#set_button_color(toggle_house, Color("#11630e"))
	#toggle_house["custom_styles/normal/bg_color"].bg_color = Color("#11630e")
	#var toggleHouseStyleBox = toggle_house.get_theme_stylebox("Normal")
	#toggleHouseStyleBox.bg_color = Color(0.2,0.9,0.9) #Color("#11630e")
	#toggle_house.add_theme_stylebox_override("Normal",toggleHouseStyleBox)
	
# Loads the selected map
func _load_map_button_pressed():
	var selected_map_index = MapDropdown.selected
	var selected_map_value = MapDropdown.get_item_text(selected_map_index)
	
	var sceneMap = load("res://Scenes/Fantismal Maps/" + selected_map_value.replace(" ","") +".tscn")
	instMap = sceneMap.instantiate()
	
	current_map.add_child(instMap)
	
	instMap.global_position = get_node("anchors/" + anchor_node +"/map_spawn_anchor").global_position
	
	set_range_circle_radius()

# Opens the option scene
func _on_options_pressed():
	options_ui = options_scene.instantiate()
	ui_layer.add_child(options_ui)
	options_ui.bypass_smudge_pause.connect(_bypass_smudge_pause)
	options_ui.flip_ui.connect(_flip_ui)
	options_ui.close_options.connect(_close_options)
	options_ui.volume_changed.connect(_set_volume)
	options_ui.opt_get_slider_from_main.connect(get_slider_value)
	
# Called when bypass_smudge button is toggled in options scene	
func _bypass_smudge_pause(state):
	print("bypass smudge pause")
	bypass_smudge_pause = state

# Called when flip_ui button is toggled in options scene	
func _flip_ui(toggled_on):
	mirror_ui = toggled_on
	if(mirror_ui):
		anchor_node = "mirror"
	else:
		anchor_node = "normal"
		
	redraw_ui()
	SmudgeTimer.define_placeholders()

# Close Option Scene
func _close_options():
	print("close options")
	options_ui.queue_free()

# Redreaw the UI - used when mirroring	
func redraw_ui():
	SmudgeTimer.global_position = get_node("anchors/" + anchor_node +"/smudge_anchor").global_position
	MapSelect.global_position = get_node("anchors/" + anchor_node +"/select_map_anchor").global_position
	RangeCreate.global_position = get_node("anchors/" + anchor_node +"/create_range_anchor").global_position
	RangeCreate.clear_ranges()
	
	option_button.global_position = get_node("anchors/" + anchor_node +"/option_button_anchor").global_position
	
	if(instMap != null):
		instMap.queue_free()

# Set the volume_db value on the TimerAudio in the CountdownTimer scene
# Also set the values for master_volume and slider_value, so they can be called by the options scene if/when it's reloaded
func _set_volume(dbVolume,sliderValue):
	TimerAudio.volume_db = dbVolume
	master_volume = dbVolume
	slider_value = sliderValue
	
# Returns the value the volume slider should be set to (0-100)
func get_slider_value():
	return slider_value

# Returns the db value that the TimerAudio.volume_db should be set to
func get_volume_value():
	return master_volume

func get_ui_mirror() -> bool:
	return mirror_ui
	
func get_bypass_smudge_pause() -> bool:
	return bypass_smudge_pause


func _on_toggle_house_pressed():
	if(instMap != null):
		instMap.toggle_house()
		toggle_house.modulate = Color("#FFFFFF")


func _on_toggle_grid_pressed():
	if(instMap != null):
		instMap.toggle_grid()


func _on_toggle_boundaries_pressed():
	if(instMap != null):
		instMap.toggle_boundaries()


func _on_toggle_legend_pressed():
	if(instMap != null):
		instMap.toggle_legend()


func _on_toggle_names_pressed():
	if(instMap != null):
		instMap.toggle_names()

func set_range_circle_radius():
	if(instMap != null):
		range_radius = instMap.get_1m_distance()
		RangeCreate.set_radius(range_radius)
		print("main:set_range_circle_radius = " + str(range_radius))

func set_button_color(button, new_color):
	var stylebox_flat = button.get_stylebox("normal")
	stylebox_flat.color = new_color
	button.add_stylebox_override("normal", stylebox_flat)
	button.self_modulate = Color(1,1,1)
