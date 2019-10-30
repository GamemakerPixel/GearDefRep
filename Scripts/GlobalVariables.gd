extends Node

const PLAYTEST_MODE = true
#Total Run Time, TowerTemplatesUsed
const PLAYTEST_SPECIFICATIONS = [true, true]

var content = []
var playtime = 0
var CompPlaytime = 0
var templatesUtilized = []

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
	var OSdate = OS.get_date() #ProjectSettings.get_setting("Application/play_test_date")
	var date = str(OSdate.month) + "_" + str(OSdate.day) + "_" + str(OSdate.year)
	print(date)
	var version = ProjectSettings.get_setting("Application/version")
	file.open("res://GearDefRep/PlaytesterData/playtest_data_" + version + "_" + date + ".txt", File.WRITE)
	file.store_string(str(content))
	file.close()
func compileData():
	if PLAYTEST_SPECIFICATIONS[0]:
		content.append("Total Play Frames: " + str(CompPlaytime) + str(" seconds"))
	if PLAYTEST_SPECIFICATIONS[1]:
		for template in templatesUtilized:
			content.append("Tower Created - " + str(template[0]) + " - at time " + str(template[1]))