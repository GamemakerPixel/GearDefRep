extends Node

const PLAYTEST_MODE = true
#Total Run Time, TowerTemplatesUsed
const PLAYTEST_SPECIFICATIONS = [true, false, true]

var content = []
#Overall Stats
var playtime = 0
var CompPlaytime = 0
var amountTowersPlaced = 0
var amountEnemiesKilled = 0
#Specific Stats
var templatesUtilized = []
var templatesUsedOnly = []
var enemiesKilled = []
#Balancing Stats
var strongestTower = ["No Tower Attacks"]
var strongestEnemy = ["No Successful Enemies"]
var mostUsedTower = ["No Towers Used"]

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
		content.append("Total Towers: " + str(amountTowersPlaced))
		content.append("Total Enemies Killed: " + str(amountEnemiesKilled))
	if PLAYTEST_SPECIFICATIONS[1]:
		if templatesUtilized.size() != 0:
			for template in templatesUtilized:
				content.append("Tower Created - " + str(template[0]) + " - at position - " + str(template[2]) + " - at time " + str(template[1]))
		else:
			content.append("Tower Created - null")
		if enemiesKilled.size() != 0:
			for enemy in enemiesKilled:
				content.append("Enemy Killed: " + str(enemy))
	if PLAYTEST_SPECIFICATIONS[2]:
		if templatesUsedOnly.size() > 0:
			mostUsedTower = mode(templatesUsedOnly)
			removeDuplicates(mostUsedTower[0])
			content.append("Most used tower(s) - " + str(mostUsedTower[0]) + " - used: " + str(mostUsedTower[1]))
		if strongestEnemy.size() > 0:
			strongestEnemy = mode(strongestEnemy)
			removeDuplicates(strongestEnemy[0])
			content.append("Strongest Enemy - " + str(strongestEnemy[0]) + " _ suceeded: " + str(strongestEnemy[1]))
		if strongestTower.size() > 0:
			var currentStrongestTower = []
			var highestDamage = 0
			for tower in strongestTower:
				if tower[1] > highestDamage:
					currentStrongestTower.clear()
					currentStrongestTower.append(tower)
					highestDamage = tower[1]
				elif tower[1] == highestDamage:
					currentStrongestTower.append(tower)
			strongestTower = currentStrongestTower
			content.append("Strongest tower - " + str(strongestTower[0]) + " - with total damage - " + str(strongestTower[1]))

func mode(Array_):
	var mostUsedValue = []
	var repitionOfValue = 0
	for i in Array_:
		var repition = Array_.count(i)
		if repition > repitionOfValue:
			mostUsedValue.clear()
			mostUsedValue.append(i)
			repitionOfValue = repition
		elif repitionOfValue == repition:
			mostUsedValue.append(i)
	return [mostUsedValue, repitionOfValue]

func removeDuplicates(Array_):
	for i in Array_:
		while Array_.count(i) > 1:
			Array_.remove(Array_.find(i))