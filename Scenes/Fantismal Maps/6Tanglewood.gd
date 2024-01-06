extends Node2D

@onready var nodeHouse = $House
@onready var nodeBoundaries = $Boundaries
@onready var nodeNames = $Names
@onready var nodeGrid = $Grid
@onready var nodeLegend = $Legend
@onready var node1mLeft = $m_left
@onready var node1mRight = $m_right

var mDistance

signal mapToggle

func _ready():
	mDistance = node1mRight.global_position.x - node1mLeft.global_position.x
	print(str(mDistance))
	
#func _draw():
#	draw_circle(Vector2(400,400),mDistance,Color.GREEN)

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
