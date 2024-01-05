extends Node2D

@onready var nodeHouse = $House
@onready var nodeBoundaries = $Boundaries
@onready var nodeNames = $Names
@onready var nodeGrid = $Grid
@onready var nodeLegend = $Legend

signal mapToggle

func toggle_house():
	nodeHouse.visible = !nodeHouse.visible
	
func toggle_boundaries():
	nodeBoundaries.visible = !nodeBoundaries.visible
	
func toggle_names():
	nodeNames.visible = !nodeNames.visible

func toggle_grid():
	nodeGrid.visible = !nodeGrid.visible
	
func toggle_legend():
	nodeLegend.visible = !nodeLegend.visible
