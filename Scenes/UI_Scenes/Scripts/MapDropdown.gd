extends OptionButton

@export var selected_map = ""
@onready var MapDropdown = get_node("/root/Main/MapSelect/MapDropdownButton")

func _on_item_selected(index):
	selected_map = get_item_text(index)
