extends Node

var content = "TestContent"

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

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		savePlaytestData()

func savePlaytestData():
	print("Saving...")
	var file = File.new()
	print("File - " + str(file))
	file.open("res://GearDefRep/PlaytesterData/playtest_data.dat", File.WRITE)
	file.store_string(content)
	file.close()