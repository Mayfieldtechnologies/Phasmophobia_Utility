extends Node2D

############################
# BEGIN GLOBAL DECLARATION #
############################

# Graphics
@onready var MapWindow = $MapLayer/MapWindow

# UI Scenes
@onready var ui_layer = $UILayer
@onready var SmudgeTimer = $UILayer/CountdownTimer
@onready var MapSelect = $UILayer/MapSelect
@onready var RangeCreate = $UILayer/RangeCreate
@onready var option_button = $UILayer/option_button
@onready var how_to_button = $UILayer/how_to_button

# CountdownTimer's Audio
@onready var TimerAudio = $UILayer/CountdownTimer/TimerAudio

# Map Scenes
@onready var MapDropdown = $UILayer/MapSelect/MapDropdown
@onready var current_map = $MapLayer/current_map

# Dialogue Scenes
@onready var options_scene = preload("res://Scenes/UI_Scenes/options.tscn")
@onready var how_to_scene = preload("res://Scenes/UI_Scenes/how_to_use.tscn")

# Map Layer Toggles
@onready var map_option_buttons = $MapLayer/MapOptionButtons
@onready var toggle_house = $MapLayer/MapOptionButtons/toggleHouse
@onready var toggle_grid = $MapLayer/MapOptionButtons/toggleGrid
@onready var toggle_boundaries = $MapLayer/MapOptionButtons/toggleBoundaries
@onready var toggle_legend = $MapLayer/MapOptionButtons/toggleLegend
@onready var togggle_names = $MapLayer/MapOptionButtons/toggleNames

@onready var zoom_level = $MapLayer/ZoomLevel

@onready var MapPlaceholder = $MapLayer/MapPlaceholder

# Instantiated Scenes
var instMap
var options_ui
var instHowTo

# Configuration Variables
var bypass_smudge_pause = false
var mirror_ui = false
var anchor_node = "normal"
var master_volume = 0
var slider_value = 50

var range_radius = 0
var dist_1m = 0.0


##########################
# END GLOBAL DELCARATION #
##########################

func _ready():
	MapSelect.loadMap.connect(_load_map_button_pressed)
	MapSelect.clearMap.connect(_clear_map_button_pressed)
	RangeCreate.CreateRange.connect(_on_range_create)
	map_option_buttons.layer_toggled.connect(_on_layer_toggled)
	map_option_buttons.set_can_toggle(false)
	#######
	# Dev Note: 01-09-24
	# I am trying to figure out how to easily control the color via code.
	# I might have to just make a texture for it.  Blargh....
	#######
	
	#set_button_color(toggle_house, Color("#11630e"))
	#toggle_house["custom_styles/normal/bg_color"].bg_color = Color("#11630e")
	#var toggleHouseStyleBox = toggle_house.get_theme_stylebox("Normal")
	#toggleHouseStyleBox.bg_color = Color(0.2,0.9,0.9) #Color("#11630e")
	#toggle_house.add_theme_stylebox_override("Normal",toggleHouseStyleBox)
	
# Loads the selected map
func _load_map_button_pressed():
	if(instMap != null):
		instMap.queue_free()
	
	# Get Selected Map Info	
	var selected_map_value = MapSelect.get_selected_map()

	if selected_map_value == "":
		return
		
	var selected_map_folder = MapSelect.get_map_folder(selected_map_value)
	
	# Hide Map Placeholder
	MapPlaceholder.visible = false
	
	# Load Blank House Scene
	var sceneMap = load("res://Scenes/Fantismal Maps/House.tscn")
	instMap = sceneMap.instantiate()
	instMap.set_zoom_string.connect(_set_zoom_string)
		
	# Make instMap a child of current_map
	current_map.add_child(instMap)
	
	# Set properties of instMap
	instMap.z_index = 2
	instMap.global_position = get_node("anchors/" + anchor_node +"/map_spawn_anchor").global_position
	
	
	
	set_range_circle_radius()
	
	
	var mapScale = instMap.get_default_scale(selected_map_value)
	print(mapScale)
	
	var x_offset = instMap.get_x_offset(selected_map_value)
	var y_offset = instMap.get_y_offset(selected_map_value)
	instMap.global_position += Vector2(x_offset,y_offset)
	instMap.scale = Vector2(mapScale,mapScale)
	
	# Set instMap's default properties
	instMap.set_default_properties(selected_map_value)
	
	map_option_buttons.set_can_toggle(true)

# Opens the option scene
func _on_options_pressed():
	if(options_ui == null):
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
	
	MapWindow.flip_h = (anchor_node == "mirror")
	
	how_to_button.global_position = get_node("anchors/" + anchor_node +"/how_to_use_button_anchor").global_position
	map_option_buttons.global_position = get_node("anchors/" + anchor_node +"/toggle_map_layers_anchor").global_position
	option_button.global_position = get_node("anchors/" + anchor_node +"/option_button_anchor").global_position

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

# Returns the state of the mirror_ui toggle from the options scene
func get_ui_mirror() -> bool:
	return mirror_ui

# Returns the state of the bypass_smudge_pause from the options scene
# Bypass Smudge Pause will just restart the smudge timer when the Start/Stop button is pressed
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
		dist_1m = instMap.update_1m_measurement()
		RangeCreate.set_radius(range_radius)
		print("main:set_range_circle_radius = " + str(range_radius))

func set_button_color(button, new_color):
	var stylebox_flat = button.get_stylebox("normal")
	stylebox_flat.color = new_color
	button.add_stylebox_override("normal", stylebox_flat)
	button.self_modulate = Color(1,1,1)

func _process(delta):
	if(instMap != null):
		if Input.is_action_just_pressed("Zoom_In"):
			instMap.zoom_in()
		elif Input.is_action_just_pressed("Zoom_Out"):
			instMap.zoom_out()
		elif Input.is_action_pressed("Pan_Map"):
			instMap.pan_map()
			print("middle click detected")
			
		elif Input.is_action_just_released("Pan_Map"):
			instMap.stop_panning()

func _on_range_create(radius,color):
	#print("Main Received Range Create")
	
	if(instMap != null):
		instMap.create_range(radius * dist_1m, color)

func _on_how_to_use_pressed():
	if(instHowTo == null):
		instHowTo = how_to_scene.instantiate()
		ui_layer.add_child(instHowTo)
		instHowTo.close_how_to_use.connect(_close_how_to)
	
func _close_how_to():
	if(instHowTo != null):
		instHowTo.queue_free()
	
func _clear_map_button_pressed():
	if(instMap != null):
		instMap.queue_free()
		MapPlaceholder.visible = true
		MapSelect.reset_dropdown()
		map_option_buttons.set_can_toggle(false)

func _set_zoom_string(zoom):
	zoom_level.text = "Zoom: " + str(zoom*100) + "%"


func _on_toggle_safe_spots_pressed():
	if(instMap != null):
		instMap.toggle_safe_spots()
		
func _on_layer_toggled(layer_name: String):
	#instMap.toggle_layer(layer_name)
	if instMap != null:
		instMap.call("toggle_" + layer_name)
