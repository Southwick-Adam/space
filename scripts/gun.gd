extends Node2D

onready var player = get_node("/root/main/player")
var gun_id = 1
var chain_out = false
var target
var max_rot = 1.22

export (PackedScene) var Chain

func _on_TouchScreenButton_pressed():
	if get_node("/root/main").gun != self:
		if player.current_land == get_node("/root/main/ship/Area2D") and gun_id < 5:
			get_node("/root/main").gun = self
			player._move("walk", $Position2D)
		elif player.current_land == get_node("/root/main/ship/platform") and gun_id >= 5:
			get_node("/root/main").gun = self
			player._move("walk", $Position2D)
	else:
		get_node("/root/main").gun = null
		player.rotation += PI/2
		if not chain_out:
			$Sprite.rotation = 0

func _shoot(targ):
	var pos_dif = targ.global_position - global_position
	var angle = (atan2(pos_dif.y,pos_dif.x))
	$Sprite.rotation = angle
	if abs(angle) <= 1.22:
		var node = Chain.instance()
		get_node("/root/main").call_deferred("add_child", node)
		chain_out = true
		node.global_position = $Sprite/barrel.global_position
		node.barrel = $Sprite/barrel
		node.gun = self
		node.target = targ
	else:
		$Sprite.rotation = 1.22 * (angle/abs(angle))
		targ.queue_free()
