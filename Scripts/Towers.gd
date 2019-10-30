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

func sellTower(_position):
	var towers = get_children()
	for tower in towers:
		if tower.position == _position:
			var worth = tower.template[5]
			var sellValue = int(worth*0.75)
			get_parent().get_node("ControlPanel/ColorRect/Stats").add_to_stat("money", sellValue)
			tower.queue_free()