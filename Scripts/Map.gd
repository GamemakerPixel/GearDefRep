extends Node2D

#x = Wave, y = Type, z = 
export (PoolVector3Array) var entityMap = []

var currentMob = 0

onready var enemy = preload("res://Characters/Enemy.tscn")

var mousedTileCoordinates = Vector2()
var mousedTileType
var towerCoordinates = []

var mobsLeft = 0

func _ready():
	$MobSpawnTimer.start()
	mobsLeft = entityMap.size()

func _process(delta):
	var usedCells = $FullEnv.get_used_cells()
	var tileMousePos = Vector2(int(get_global_mouse_position().x * 1.5 / 32) - 1, int(get_global_mouse_position().y * 1.5 / 16)).rotated(deg2rad(-45)) #-26.565
	var intTileMousePos = Vector2(int(tileMousePos.x), int(tileMousePos.y)) #11, 1
	print(intTileMousePos)
	mousedTileCoordinates = intTileMousePos
	mousedTileType = $FullEnv.get_cell(mousedTileCoordinates.x, mousedTileCoordinates.y)
	var _2DTilePos =  mousedTileCoordinates.rotated(deg2rad(45)) * Vector2(32 / 1.5, 16 / 1.5) + Vector2(32, 16)
	$SelectedTile.position = _2DTilePos #highlightedTilePos
	if Input.is_action_just_pressed("mainClick"):
		if GlobalVariables.mouseMode == 1:
			if not towerCoordinates.has(_2DTilePos):
				$Towers.placeTower($ControlPanel/ColorRect/Templates.templateInt, _2DTilePos)
				towerCoordinates.append(_2DTilePos)
	var highlightedTilePos = Vector2(int(get_global_mouse_position().x / 16) * 16, int(get_global_mouse_position().y / 16) * 16)

func _spawnMonster(type):
	var mobInstance = null
	mobInstance = enemy.instance()
	
	mobInstance.position = $MonsterSpawners/MonsterSpawner.position + $MonsterSpawners/MonsterSpawner/SpawnPos.position
	mobInstance.destination = $Castle.position + $Castle/EndingPos.position
	
	var path = $EnemyNav.get_simple_path($MonsterSpawners/MonsterSpawner.position + $MonsterSpawners/MonsterSpawner/SpawnPos.position, $Castle/EndingPos.position + $Castle.position)
	mobInstance.set_path(path)
	
	mobInstance.setEnemy(entityMap[currentMob].z)
	
	$MobSpawnTimer.wait_time = entityMap[currentMob].y + 1
	
	$Entities.add_child(mobInstance)
	mobsLeft -= 1
	if mobsLeft > 0:
		currentMob += 1
		$MobSpawnTimer.start()

func _on_MobSpawnTimer_timeout():
	if mobsLeft > 0:
		_spawnMonster(0)

func _on_CreateBiulding_pressed():
	$ControlPanel/CreateScreen.show()

func _on_Button_pressed():
	$ControlPanel/CreateScreen.hide()

func placeTower(template_):
	var t = preload("res://Characters/Tower.tscn").instance()
	t.setData(template_, get_global_mouse_position())