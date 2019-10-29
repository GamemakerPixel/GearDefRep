extends Node2D

var health = GlobalVariables.DEFAULT_HEALTH
var money = GlobalVariables.DEFAULT_MONEY

func _ready():
	update_visuals()

func set_stat(stat, value, playHurtAnim = true):
	if stat == "health":
		health = value
		if playHurtAnim:
			$AnimationPlayer.play("CastleHurt")
	if stat == "money":
		money = value
	update_visuals()

func add_to_stat(stat, value):
	if stat == "health":
		health += value
	if stat == "money":
		money += value
	update_visuals()

func update_visuals():
	$Health.text = str(health)
	$Money.text = str(money)