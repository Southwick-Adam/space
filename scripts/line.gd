extends Node2D

onready var player = get_node("/root/main/player")
onready var hand = get_node("/root/main/player/hand")

var target
var velocity = Vector2()
var hooked_vel = Vector2()
var new_land

const SPEED = 600
var MAX_DIST = 200

var state = ("idle")

func _go(targ):
	$hook.global_position = hand.global_position
	set_process(true)
	state = ("flying")
	target = targ
	$hook.call_deferred("monitoring", true)

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
	var main = get_node("/root/main")
	if area == main.target_land:
		hooked_vel = area.get_parent().velocity
		state = ("hooked")
		$hook/Sprite.texture = preload("res://assets/player/hooked.png")
		main.target_land = null
		new_land = area
		player._move("zip", $hook/Position2D)
	elif area == get_node("/root/main/player/Area2D"):
		if state == ("hooked"):
			hide()
		elif state == ("retract"):
			main.target_land = null
			player.line_out = false
			_dormant()
	elif area.is_in_group("item"):
		state = ("retract")

func _dormant():
	hide()
	$hook.call_deferred("monitoring", false)
	state = ("idle")
	$hook/Sprite.texture = preload("res://assets/player/hook.png")
	set_process(false)
