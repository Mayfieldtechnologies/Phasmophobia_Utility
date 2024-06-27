extends Control



signal bypass_smudge_pause(pause)
signal flip_ui(flip)
signal close_options

# Volume Signals
signal volume_changed(arg1,arg2)
signal opt_get_slider_from_main


@onready var bypass_smudge_pause_button = $Panel/bypass_smudge_pause_button
@onready var flip_ui_button = $Panel/flip_ui_button
@onready var volume = $Panel/volume

var main_scene

var master_volume = 0
var slider_value = 50

func _ready():
	volume.get_slider_from_main.connect(get_slider_from_main)
	main_scene = find_parental(self,"Main")
	
	bypass_smudge_pause_button.button_pressed = main_scene.get_bypass_smudge_pause()
	flip_ui_button.button_pressed = main_scene.get_ui_mirror()
	
	print(main_scene.get_ui_mirror())
	
######################
#   SIGNAL EMITTERS  #
######################

# Bypass Smudge Emitter
func _on_bypass_smudge_pause_toggled(toggled_on):
	emit_signal("bypass_smudge_pause", toggled_on)

# Flip UI Emitter
func _on_flip_ui_toggled(toggled_on):
	emit_signal("flip_ui",toggled_on)

# Close Options Emitter
func _on_close_options_pressed():
	emit_signal("close_options")

# Volume Changed Emitter
# TRIGGERED BY THE volume NODE.
# Acts as a signal hop
func _on_volume_new_volume(dbValue, sliderValue):
	emit_signal("volume_changed",dbValue,sliderValue)

# Get Slider Value From Main Emitter
# Returns the value (0-100) that the volume slider needs to be set to when the options window loads
func get_slider_from_main():
	slider_value = emit_signal("opt_get_slider_from_main")
	return slider_value
	

func get_volume():
	master_volume = volume.get_master_volume()
	return master_volume
	
func set_master_volume(arg1):
	master_volume = arg1
	
func set_slider_value(arg1):
	slider_value = arg1

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
