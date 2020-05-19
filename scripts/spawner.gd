extends Node2D

export (PackedScene) var Island
export (PackedScene) var Scrap

var lane = true

func _ready():
	_spawn_island()
	_spawn_island()

func _on_IslandTimer_timeout():
	_spawn_island()

func _spawn_island():
	randomize()
	var node = Island.instance()
	get_node("/root/main").call_deferred("add_child", node)
	if lane:
		node.global_position = Vector2(320 + (220 * randf()), -140)
		lane = false
	else:
		node.global_position = Vector2(865 + (235 * randf()), -140)
		lane = true

func _on_ScrapTimer_timeout():
	randomize()
	var node = Scrap.instance()
	get_node("/root/main").call_deferred("add_child", node)
	node.global_position.x = 300 + (800 * randf())
	node.global_position.y = -50 
