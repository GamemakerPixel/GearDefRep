extends YSort

var currentTemplate = null

func placeTower(templateInt, _position):
	var tower = preload("res://GearDefRep/Characters/Tower.tscn")
	var t = tower.instance()
	add_child(t)
	t.setData(GlobalVariables.biuldingTemplates[templateInt], _position)
	
	t = null
	get_parent().get_node("ControlPanel/ColorRect/Stats").add_to_stat("money", -GlobalVariables.biuldingTemplates[templateInt][5])
	GlobalVariables.setMouseMode(0)
	get_parent().get_node("MouseAttachments")._hide("RangeCircle")