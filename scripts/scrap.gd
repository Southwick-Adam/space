extends Node2D


var type = ("metal")
var velocity = Vector2(0,0)
var hooked = false
var hook

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	var type_rng = randf()
	var type_texture = preload("res://assets/items/metal.png")
	if type_rng >= 0.3 and type_rng < 0.6:
		type = ("wood")
		type_texture = preload("res://assets/items/wood.png")
	elif type_rng >= 0.6 and type_rng < 0.9:
		type = ("energy")
		type_texture = preload("res://assets/items/energy.png")
	elif type_rng >= 0.9:
		type = ("tech")
		type_texture = preload("res://assets/items/tech.png")
	$Area2D/Sprite.texture = type_texture
	$Area2D/Sprite2.texture = type_texture
	$Area2D/Sprite3.texture = type_texture

	var n = 0
	var texture_rng = RandomNumberGenerator.new()
	var rot_rng = RandomNumberGenerator.new()
	while n < 3:
		texture_rng.randomize()
		rot_rng.randomize()
		$Area2D.get_child(n).frame = texture_rng.randi_range(0,4)
		$Area2D.get_child(n).rotation = randf() * 2 * PI
		n += 1

	velocity.y = 50 + (80 * randf())

func _process(delta):
	if hooked:
		if get_node("/root/main/line") != null:
			velocity = get_node("/root/main/line").velocity
	position += velocity * delta

func _on_Area2D_area_entered(area):
	if area == get_node("/root/main/player/Area2D"):
		if type == ("metal"):
			get_node("/root/main/CanvasLayer/UI").metal += 1
		elif type == ("wood"):
			get_node("/root/main/CanvasLayer/UI").wood += 1
		elif type == ("energy"):
			get_node("/root/main/CanvasLayer/UI").energy += 1
		elif type == ("tech"):
			get_node("/root/main/CanvasLayer/UI").tech += 1
		queue_free()
	elif area == get_node("/root/main/line/hook"):
		hooked = true

func _on_TouchScreenButton_pressed():
	get_node("/root/main/player")._zip(self)
