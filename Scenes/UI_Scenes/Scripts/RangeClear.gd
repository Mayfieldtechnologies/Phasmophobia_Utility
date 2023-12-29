extends Button

func _on_pressed():
	clear_ranges()

func clear_ranges():
	for circle in get_tree().get_nodes_in_group("Circle"):
		circle.queue_free()
