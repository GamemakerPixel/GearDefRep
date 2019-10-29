extends Node2D



func _process(delta):
	position = get_global_mouse_position()

func reveal(node, additionalValues = null):
	if node == "RangeCircle":
		$RangeCircle.scale = Vector2(0.45 * additionalValues, 0.45 * additionalValues)
		$RangeCircle.show()

func _hide(node):
	get_node(node).hide()
