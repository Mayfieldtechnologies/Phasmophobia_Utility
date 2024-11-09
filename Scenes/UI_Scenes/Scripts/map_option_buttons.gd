extends Node2D

@onready var toggleHouse = $toggleHouse
@onready var toggleGrid = $toggleGrid
@onready var toggleNames = $toggleNames
@onready var toggleBoundaries = $toggleBoundaries
@onready var toggleLegend = $toggleLegend
@onready var toggleSafeSpots = $toggleSafeSpots

signal layer_toggled(layer_name: String)

func _ready():
	toggleHouse.state_toggled.connect(house_toggled)
	toggleGrid.state_toggled.connect(grid_toggled)
	toggleNames.state_toggled.connect(names_toggled)
	toggleBoundaries.state_toggled.connect(boundaries_toggled)
	toggleLegend.state_toggled.connect(legend_toggled)
	toggleSafeSpots.state_toggled.connect(safe_spots_toggled)
	
func set_can_toggle(can_toggle):
	toggleHouse.set_can_toggle(can_toggle)
	toggleGrid.set_can_toggle(can_toggle)
	toggleNames.set_can_toggle(can_toggle)
	toggleBoundaries.set_can_toggle(can_toggle)
	toggleLegend.set_can_toggle(can_toggle)
	toggleSafeSpots.set_can_toggle(can_toggle)

func house_toggled(button_state: bool):
	emit_signal("layer_toggled", "house")
	
func grid_toggled(button_state: bool):
	emit_signal("layer_toggled", "grid")

func names_toggled(button_state: bool):
	emit_signal("layer_toggled", "names")

func boundaries_toggled(button_state: bool):
	emit_signal("layer_toggled", "boundaries")

func legend_toggled(button_state: bool):
	emit_signal("layer_toggled", "legend")
	
func safe_spots_toggled(button_state: bool):
	emit_signal("layer_toggled", "safe_spots")
