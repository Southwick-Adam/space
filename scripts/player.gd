extends Node2D

var SPEED = 150
var velocity = Vector2()
var ground_vel = 0

var state = ("idle")
var target
onready var current_land = get_node("/root/main/ship/dock")
onready var line = get_node("/root/main/line")
var line_out = false

func _ready():
	pass

func _process(delta):
	ground_vel = current_land.get_parent().velocity.y
	if state == ("idle"): #STATIONARY
		velocity = Vector2(0, ground_vel)
	else: #WE ARE MOVING
		var pos_dif = target.global_position - global_position
		rotation = (atan2(pos_dif.y,pos_dif.x) - PI/2)
		velocity = Vector2(cos(rotation + PI/2), sin(rotation + PI/2))
		if state == ("walk"):
			velocity = (velocity.normalized() * SPEED) + Vector2(0, ground_vel)
			_animate("walk")
		elif state == ("zip"):
			velocity = (velocity.normalized() * SPEED * 4)
			_animate("zip")
#REACHING TARGET
		if abs(pos_dif.x) < 8 and abs(pos_dif.y) < 8:
			if state == ("zip"):
				current_land = line.new_land
				line._dormant()
				line_out = false
			elif state == ("walk"):
				if target.get_parent().name == ("gun"):
					rotation = -PI/2
				else:
					target = null
			state = ("idle")
			_animate("idle")
	position += velocity * delta

func _move(type, targ):
	state = type
	target = targ

func _zip(targ):
#ROTATE TWOARDS MARK
	var pos_dif = targ.global_position - global_position
	rotation = (atan2(pos_dif.y,pos_dif.x) - PI/2)
	state = ("idle")
	line_out = true
	line.show()
	line._go(targ)

func _animate(anim):
	if $AnimationPlayer.current_animation != anim:
		$AnimationPlayer.play(anim)
