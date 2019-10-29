extends Sprite

signal template_selected

var selected = false

func _ready():
	$Button.connect("pressed", self, "_on_Button_pressed")

func _on_Button_pressed():
	selected = true
	emit_signal("template_selected", name)

func selectButton(selected):
	if selected:
		texture = preload("res://Sprites/Icons/Biulding Creation/tile004.png")
		GlobalVariables.setMouseMode(1)
	else:
		texture = preload("res://Sprites/Icons/Biulding Creation/tile003.png")

func _process(delta):
	if GlobalVariables.mouseMode == 0:
		selectButton(false)
