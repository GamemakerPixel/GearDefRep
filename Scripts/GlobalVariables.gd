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
	var file = File.new()
	var OSdate = OS.get_date()
	var OStime = OS.get_time()
	var time = str(OStime.hour) + "-" + str(OStime.minute)
	var ComputerName = OS.get_name()
	var date = str(OSdate.month) + "_" + str(OSdate.day) + "_" + str(OSdate.year)
	var version = ProjectSettings.get_setting("Application/version")
	file.open("res://GearDefRep/PlaytesterData/" + ComputerName + "/playtest_data_" + version + "_" + date + "_" + time + ".txt", File.WRITE)
	file.store_string(to_json(content))
	file.close()
func compileData():
	if PLAYTEST_SPECIFICATIONS[0]:
		content.append("Total Play Time: " + str(CompPlaytime) + str(" seconds"))
	if PLAYTEST_SPECIFICATIONS[1]:
		if templatesUtilized.size() != 0:
			for template in templatesUtilized:
				content.append("Tower Created - " + str(template[0]) + " - at position - " + str(template[2]) + " - at time " + str(template[1]))
		else:
			content.append("Tower Created - null")