extends ColorRect

var activeButton = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile004.png")
var inactiveButton = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile003.png")

var currentBase
var currentElement
var cost = 15

var damageCost = 5
var rangeCost = 5
var speedCost = 5
var elementCost = 0

func _ready():
	_on_None_pressed()
	_on_Single_pressed()

func _update_visuals(type):
	clearButtons(type)
	setActiveButtons()

func clearButtons(type):
	if type == "Bases":
		$Bases/Splash.texture_normal = inactiveButton
		$Bases/Single.texture_normal = inactiveButton
		$Bases/Multi.texture_normal = inactiveButton
		$Bases/Full.texture_normal = inactiveButton
	if type == "Elements":
		$Elements/Fire.texture_normal = inactiveButton
		$Elements/Fire/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile011.png")
		$Elements/Water.texture_normal = inactiveButton
		$Elements/Water/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile012.png")
		$Elements/Wind.texture_normal = inactiveButton
		$Elements/Wind/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile013.png")
		$Elements/Nature.texture_normal = inactiveButton
		$Elements/Nature/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile014.png")
		$Elements/None.texture_normal = inactiveButton
		$Elements/None/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile015.png")

func setActiveButtons():
	if currentBase == 0:
		$Bases/Splash.texture_normal = activeButton
	elif currentBase == 1:
		$Bases/Single.texture_normal = activeButton
	elif currentBase == 2:
		$Bases/Multi.texture_normal = activeButton
	elif currentBase == 3:
		$Bases/Full.texture_normal = activeButton
	if currentElement == 0:
		$Elements/None.texture_normal = activeButton
		$Elements/None/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile010.png")
	elif currentElement == 1:
		$Elements/Fire.texture_normal = activeButton
		$Elements/Fire/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile006.png")
	elif currentElement == 2:
		$Elements/Water.texture_normal = activeButton
		$Elements/Water/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile007.png")
	elif currentElement == 3:
		$Elements/Wind.texture_normal = activeButton
		$Elements/Wind/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile008.png")
	elif currentElement == 4:
		$Elements/Nature.texture_normal = activeButton
		$Elements/Nature/Sprite.texture = preload("res://GearDefRep/Sprites/Icons/Biulding Creation/tile009.png")

func setCost(type, value):
	if type == "DamageSlider":
		damageCost = value
	elif type == "RangeSlider":
		rangeCost = value
	elif type == "SpeedSlider":
		speedCost = value
	elif type == "Element":
		elementCost = value
	cost = damageCost + rangeCost + speedCost + elementCost
	$Cost.text = str(cost)

func createBiuldingTemplate():
	var template = [currentBase, currentElement, $Sliders/DamageSlider.value, $Sliders/SpeedSlider.value, $Sliders/RangeSlider.value, cost]
	GlobalVariables.biuldingTemplates.append(template)
func _on_Splash_pressed():
	currentBase = 0
	_update_visuals("Bases")
	$Sliders/DamageSlider.setMaxValue(8) #40%

func _on_Single_pressed():
	currentBase = 1
	_update_visuals("Bases")
	$Sliders/DamageSlider.setMaxValue(20) #100%

func _on_Multi_pressed():
	currentBase = 2
	_update_visuals("Bases")
	$Sliders/DamageSlider.setMaxValue(12) #60%

func _on_Full_pressed():
	currentBase = 3
	_update_visuals("Bases")
	$Sliders/DamageSlider.setMaxValue(5) #25%

func _on_Fire_pressed():
	currentElement = 1
	_update_visuals("Elements")
	setCost("Element", 20)

func _on_Water_pressed():
	currentElement = 2
	_update_visuals("Elements")
	setCost("Element", 20)

func _on_Wind_pressed():
	currentElement = 3
	_update_visuals("Elements")
	setCost("Element", 20)

func _on_Nature_pressed():
	currentElement = 4
	_update_visuals("Elements")
	setCost("Element", 20)

func _on_None_pressed():
	currentElement = 0
	_update_visuals("Elements")
	setCost("Element", 0)

func _on_Create_pressed():
	createBiuldingTemplate()
	self.hide()