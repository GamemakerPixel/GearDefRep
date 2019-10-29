extends Node2D

var broken = false
var health = GlobalVariables.DEFAULT_HEALTH

func _ready():
	if broken:
		$Sprite.region_rect.position = Vector2(0, 160)

func injureCastle(damage):
	health -= damage
	var playAnim = true
	if damage < 0:
		playAnim = false
	get_parent().get_node("ControlPanel/ColorRect/Stats").set_stat("health", health, playAnim)
	if health <= 0:
		$Sprite.region_rect.position = Vector2(0, 160)