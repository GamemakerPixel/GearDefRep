extends Node2D

var nextAvalibleTemplate
var nextTemplateInt
var nextTemplatePath

var templateInt = null

func _ready():
	var children = get_children()
	for child in children:
		child.connect("template_selected", self, "_on_template_selected")

func _process(delta):
	nextTemplateInt = GlobalVariables.biuldingTemplates.size() - 1
	nextTemplatePath = "Template" + str(nextTemplateInt)
	if GlobalVariables.biuldingTemplates.size() > 0:
		nextAvalibleTemplate = get_node(nextTemplatePath)
		enableTemplate(GlobalVariables.biuldingTemplates[nextTemplateInt])

func enableTemplate(template):
	nextAvalibleTemplate.get_node("Sprite").texture = calculateTexture(template)
	nextAvalibleTemplate.get_node("Cost").text = str(template[5]) 
	nextAvalibleTemplate.show()

func calculateTexture(template):
	if template[1] == 0 && template[0] == 0:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile016.png")
	elif template[1] == 0 && template[0] == 1:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile017.png")
	elif template[1] == 0 && template[0] == 2:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile018.png")
	elif template[1] == 0 && template[0] == 3:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile019.png")
	elif template[1] == 1 && template[0] == 0:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile000.png")
	elif template[1] == 1 && template[0] == 1:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile001.png")
	elif template[1] == 1 && template[0] == 2:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile002.png")
	elif template[1] == 1 && template[0] == 3:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile003.png")
	elif template[1] == 2 && template[0] == 0:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile004.png")
	elif template[1] == 2 && template[0] == 1:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile005.png")
	elif template[1] == 2 && template[0] == 2:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile006.png")
	elif template[1] == 2 && template[0] == 3:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile007.png")
	elif template[1] == 3 && template[0] == 0:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile008.png")
	elif template[1] == 3 && template[0] == 1:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile009.png")
	elif template[1] == 3 && template[0] == 2:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile010.png")
	elif template[1] == 3 && template[0] == 3:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile011.png")
	elif template[1] == 4 && template[0] == 0:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile012.png")
	elif template[1] == 4 && template[0] == 1:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile013.png")
	elif template[1] == 4 && template[0] == 2:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile014.png")
	elif template[1] == 4 && template[0] == 3:
		return preload("res://Sprites/Icons/Biulding Creation/TowerIcons/tile015.png")

func _on_template_selected(templateName):
	if GlobalVariables.biuldingTemplates[int(templateName)][5] <= get_parent().get_node("Stats").money:
		var currentTemplateNode = get_node(templateName)
		var otherTemplates = get_children()
		var currentTemplateLocation = otherTemplates.find(get_node(templateName))
		otherTemplates.remove(currentTemplateLocation)
		currentTemplateNode.selectButton(true)
		templateInt = int(templateName)
		get_parent().get_parent().get_parent().get_node("MouseAttachments").reveal("RangeCircle", GlobalVariables.biuldingTemplates[templateInt][4])
		for templateButton in otherTemplates:
			templateButton.selectButton(false)
	else:
		get_parent().get_node("Stats/AnimationPlayer").play("InsufficientMoney")