extends Control

# x-coords
# 0% 	- 17
# 50% 	- 108
# 100% 	- 202

var xCoords = {
	0: 17,
	50: 108,
	100: 202	
}

# Master volume variable (range 0 to 1)
var master_volume = 1.0

func _on_volume_bar_value_changed(value):
	print(value)
	set_master_volume(value/100)
	

# Function to set the master volume
func set_master_volume(volume: float):
	master_volume = clamp(volume, 0.0, 1.0)
	
	# Get the bus index for the master bus
	var master_bus_index = AudioServer.get_bus_index("Master")
	print("master_bus_index=" + str(master_bus_index))
	
	# Set the volume for the master bus
	AudioServer.set_bus_volume_db(master_bus_index, master_volume)

# Function to get the master volume
func get_master_volume() -> float:
	return master_volume
