extends Node2D

export (int) var _type = 0
export (int) var spawnPort

func _ready():
	setSprite()

func setSprite():
	var SpriteLocations = [Vector2(0, 0), Vector2(96, 0), Vector2(0, 96), Vector2(96, 96)]
	$Sprite.region_rect.position = SpriteLocations[_type]
	