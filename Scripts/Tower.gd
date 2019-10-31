extends Node2D

var template

var type
var effect
var speed
var damage
var range_

var can_shoot = true
var target = null

func _ready():
	pass
	#setData([0, 0, 8, 4, 5], Vector2(852, 456))

func setData(_template, _position):
	if template == null:
		template = _template
		position = _position
		readTemplate(template)
	if GlobalVariables.PLAYTEST_MODE:
		GlobalVariables.templatesUtilized.append([template, GlobalVariables.CompPlaytime, _position])

func readTemplate(template):
	type = template[0]
	effect = template[1]
	damage = template[2]
	range_ = template[4]
	if template[3] == 1:
		speed = 5
	elif template[3] == 2:
		speed = 3
	elif template[3] == 3:
		speed = 1
	elif template[3] == 4:
		speed = 0.5
	applyTemplate()

func applyTemplate():
	var newRangeShape = CircleShape2D.new()
	
	$Cooldown.wait_time = speed
	newRangeShape.radius = 16 + range_ * 16
	$Range/RangeShape.shape = newRangeShape

func _on_Range_body_entered(body):
	if target == null:
		if body.has_method("takeDamage"):
			target = body
			shoot()

func shoot():
	if can_shoot:
		if target != null:
			if (target.health - damage) <= 0:
				target.takeDamage(damage)
				target.die()
				target = null
				var otherBodies = $Range.get_overlapping_bodies()
				if otherBodies.size() > 1:
					var livingEntities = get_parent().get_parent().get_node("Entities").get_children() #target = otherBodies[0] #target = otherBodies[otherBodies.size() - 1]
					target = otherBodies.back()
					#for e in otherBodies:
						#print("Testing " + str(e))
						#if livingEntities.has(e):
							#print("Testing " + str(e) + " result - is in livingEntities")
							#target = e
							#if target.health <= 0:
								#target = null
							#break
				else:
					target = null
			else:
				target.takeDamage(damage)
			can_shoot = false
			$Cooldown.start()

func _on_Cooldown_timeout():
	can_shoot = true
	shoot()

func _on_Range_body_exited(body):
	if body == target:
		target = null
