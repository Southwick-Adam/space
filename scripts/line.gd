extends Node2D

onready var player = get_node("/root/main/player")
onready var hand = get_node("/root/main/player/hand")

var target
var velocity = Vector2()
var hooked_vel = Vector2()
var new_land

const SPEED = 600
var MAX_DIST = 200

var state = ("flying")

func _process(delta):
#ESTABLISHING DISTANCE FROM PLAYER TO HOOK
	var dist = $hook.global_position - hand.global_position
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
		var pos_dif = hand.global_position - $hook.global_position
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
	if area.is_in_group("land") and area != player.current_land:
		hooked_vel = area.get_parent().velocity
		state = ("hooked")
		target.queue_free()
		new_land = area
		player._move("zip", $hook/Position2D)
	elif area == get_node("/root/main/player/Area2D"):
		if state == ("hooked"):
			hide()
		elif state == ("retract"):
			target.queue_free()
			player.line_out = false
			queue_free()
