extends Node2D

export (PackedScene) var Island

var lane = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


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
