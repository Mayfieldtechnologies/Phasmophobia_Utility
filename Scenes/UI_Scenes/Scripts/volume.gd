extends Control

# Signal Declaration
signal new_volume(dbValue,sliderValue)
signal get_slider_from_main

@onready var VolumeSlider = $VolumeSlider
@onready var VolumeString = $VolumeSlider/VolumeString
var main_scene

var CurrentVolume

func _ready():
	# Locate main scene
	main_scene = find_parental(self, "Main")
	
	# Define VolumeSlider's value by calling the get_slider_value function from main_scene
	VolumeSlider.value = main_scene.get_slider_value()

# Function to get the master volume
func get_master_volume() -> float:
	return CurrentVolume
	
# Called when the volume slider is changed
# This emits the "new_volume" signal at the end, which is triggered in the options scene
func _on_volume_slider_value_changed(value):
	VolumeString.text = str(value) + " %"
	CurrentVolume = -24 + (value/100) * 48
	emit_signal("new_volume",CurrentVolume,value)

# Recursively searches all parental nodes for a specific target_node
func find_parental(current_node, target_node):
	# Check if current_node is the target_node
	if(current_node.name == target_node):
		return current_node
	
	# Define parent_node of current_node
	var parent_node = current_node.get_parent()
	
	# Check if parent_node is defined
	if parent_node:
		# Recursively run this function and store value in result
		var result = find_parental(parent_node, target_node)
		
		# Return the parent_node as the result if it is defined.
		if result:
			return result
