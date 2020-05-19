extends Node2D

var gun
var barrel

var target
var velocity = Vector2()
var hooked_vel = Vector2()
var hooked_land

const SPEED = 600
var MAX_DIST = 3000

var state = ("flying")

func _process(delta):
	print($hook.monitoring)
#ESTABLISHING DISTANCE FROM GUN TO HOOK
	var dist = $hook.global_position - barrel.global_position
	var straight_dist = sqrt(pow(dist.x, 2) + pow(dist.y, 2))
#FLYING
	if state == ("flying"):
		var pos_dif = target.global_position - $hook.global_position
		$hook.rotation = (atan2(pos_dif.y,pos_dif.x) + PI/2)
		velocity = Vector2(cos($hook.rotation - PI/2), sin($hook.rotation - PI/2))
		velocity = (velocity.normalized() * SPEED)
#REACHING LENGTH
		if straight_dist > MAX_DIST:
			state = ("retract")
#RETRACTING
	elif state == ("retract"):
		var pos_dif = barrel.global_position - $hook.global_position
		var rot = (atan2(pos_dif.y,pos_dif.x) + PI/2)
		velocity = Vector2(cos(rot - PI/2), sin(rot - PI/2))
		velocity = (velocity.normalized() * SPEED)
#HOOKED
	elif state == ("hooked"):
		velocity = hooked_vel
#HOOK POS UPDATE
	$hook.position += velocity * delta
#ROPE SIZE, POS, ROT
	$links.region_rect.size.y = straight_dist
	$links.global_position = $hook.global_position - dist/2
	$links.rotation = (atan2(dist.y,dist.x) + PI/2)

func _on_hook_area_entered(area):
	if area == get_node("/root/main").target_land and state == ("flying"):
		hooked_vel = Vector2(0,0)
		area.get_parent().velocity = Vector2(0,0)
		state = ("hooked")
		hooked_land = area.get_parent()
		$hook.set_deferred("monitoring", false)
		$hook/Sprite.texture = preload("res://assets/boat/hooked.png")
	elif area == gun.get_node("Area2D") and state == ("retract"):
			target.queue_free()
			gun.chain_out = false
			queue_free()

func _on_TouchScreenButton_pressed():
	if state == ("hooked") and get_node("/root/main").gun == gun:
		state = ("retract")
		$hook.set_deferred("monitoring", true)
		hooked_land.velocity = hooked_land.saved_vel
