extends KinematicBody2D

var speed = 100
var path : = PoolVector2Array() setget set_path
var destination = Vector2()
var onPathPoint = 0
var direction

var maxHealth = 1
var health = 1
var type = null

func setEnemy(_type):
	type = _type
	if type == 0:
		health = 1
		speed = 40
		$AnimatedSprite.play("0Move")
	elif type == 1:
		health = 3
		speed = 30
		$AnimatedSprite.play("1Move")
	elif type == 2:
		health = 5
		speed = 20
		$AnimatedSprite.play("2Move")
	maxHealth = health

func _physics_process(delta):
	if type != null:
		if path.size() > 0:
			var distance = speed * delta
			move_along_path(distance)
		elif abs(position.x - destination.x) < 10 && abs(position.y - destination.y) < 10:
			attackCastle()
		updateVisuals()

func attackCastle():
	get_parent().get_parent().get_node("Castle").injureCastle(health)
	queue_free()

func updateVisuals():
	determineDirection()
	if direction == "right":
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play(str(type) + "Move")
	if direction == "left":
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play(str(type) + "Move")

func determineDirection():
	if path.size() > 0:
		if position.x < path[0].x && position.y > path[0].y:
			direction = "right"
		elif position.x < path[0].x && position.y < path[0].y:
			direction = "rear"
		elif position.x > path[0].x && position.y > path[0].y:
			direction = "front"
		elif position.x > path[0].x && position.y < path[0].y:
			direction = "left"



func move_along_path(distance):
	var start_pos = position
	for i in range(path.size()):
		var distance_to_next = start_pos.distance_to(path[0]) #0
		if distance <= distance_to_next && distance > 0:
			position = start_pos.linear_interpolate(path[0], distance / distance_to_next) #0
			break
		elif distance <= 0:
			position = path[0]
			break
		
		distance -= distance_to_next
		start_pos = path[0]
		path.remove(0)

func set_path(new_path):
	path = new_path

func takeDamage(damage):
	health -= damage
	if health <= 0:
		pass #die()

func die():
	get_parent().get_parent().get_node("ControlPanel/ColorRect/Stats").add_to_stat("money", calculateWorth())
	calculateWorth()
	queue_free()

func calculateWorth():
	var floatWorth = maxHealth * (speed / 10 / 2)
	floatWorth *= 1.5
	var intWorth = int(floatWorth)
	return intWorth
