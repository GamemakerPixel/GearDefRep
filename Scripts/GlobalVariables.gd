extends Node

const DEFAULT_HEALTH = 100
const DEFAULT_MONEY = 200

#0 = Normal, 1 = Biuld
var mouseMode = 0

var biuldingTemplates = []

func setMouseMode(mode):
	if mode == 0:
		Input.set_custom_mouse_cursor(null)
	elif mode == 1:
		Input.set_custom_mouse_cursor(preload("res://GearDefRep/Sprites/Icons/Mouse Cursors/TowerCreate.png"))
	mouseMode = mode
