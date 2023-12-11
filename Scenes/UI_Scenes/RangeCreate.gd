extends Control

@export var selected_range_value = ""
@export var zIndex = 3
@onready var RangeDropdown = get_node("/root/Main/RangeSelect/RangeDropdown")
@onready var RangeCircles = get_node("/root/Main/Current/RangeCircles")
@onready var RangeColor = get_node("/root/Main/RangeSelect/RangeColor")

@export var draw_circle: bool = false

func _on_pressed():
	var selected_range_index = RangeDropdown.selected
	selected_range_value = float(RangeDropdown.get_item_text(selected_range_index))
	
	LoadRange()

func LoadRange():
	var sceneRange = load("res://Scenes/Distance_Scenes/1m.tscn")
	var instRange = sceneRange.instantiate()
	
	RangeCircles.add_child(instRange)
	instRange.global_scale = Vector2(selected_range_value*2,selected_range_value*2)
	instRange.global_position = Vector2(800,400)
	
	instRange.modulate = RangeColor.color
	instRange.modulate.a = 0.5
	instRange.z_index = zIndex
	zIndex += 1

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PackedVector2Array()
	points_arc.push_back(center)
	var colors = PackedColorArray([color])

	for i in range(nb_points + 1):
		var angle_point = deg_to_rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
