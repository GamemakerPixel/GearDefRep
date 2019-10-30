extends Node

var content = []
var playtime = 0
var CompPlaytime = 0
var templatesUtilized = PoolVector2Array()

const DEFAULT_HEALTH = 100
const DEFAULT_MONEY = 200

#0 = Normal, 1 = Biuld
var mouseMode = 0

var biuldingTemplates = []

func _process(delta):
	playtime += delta
	CompPlaytime = round(playtime * 100) / 100

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
	compileData()
	print("Saving...")
	var file = File.new()
	print("File - " + str(file))
	var date = ProjectSettings.get_setting("Application/playTestDate")
	var version = ProjectSettings.get_setting("Application/version")
	file.open("res://GearDefRep/PlaytesterData/playtest_data_" + version + "_" + date + ".txt", File.WRITE)
	file.store_string(str(content))
	file.close()
func compileData():
	content.append("Total Play Frames: " + str(CompPlaytime) + str(" seconds"))