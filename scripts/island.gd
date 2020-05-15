extends Node2D

onready var main = get_node("/root/main")
var velocity = Vector2(0,0)

func _ready():
	randomize()
	var size_rng = randf()
	var speed_rng = randf()
	var scale_comp = 0.7 + (.7 * size_rng)
	scale = Vector2(scale_comp,scale_comp)
	velocity.y = 30 + (50 * speed_rng)

func _process(delta):
	position += velocity * delta

func _on_Area2D_mouse_entered():
	main.mouse_pos.append($Area2D)

func _on_Area2D_mouse_exited():
	main.mouse_pos.erase($Area2D)
