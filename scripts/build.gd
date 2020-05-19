extends Node2D

var site1 = 0
var site2 = 0
var site3 = 0
var site4 = 0
var site5 = 0
var site6 = 0

onready var UI = get_node("/root/main/CanvasLayer/UI")

func _ready():
	$player_btn.global_position = get_node("/root/main/player").global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_build1_pressed():
	_deck_build(1)
func _on_build2_pressed():
	_deck_build(2)
func _on_build3_pressed():
	_deck_build(3)
func _on_build4_pressed():
	_deck_build(4)
func _on_build5_pressed():
	_deck_build(5)
func _on_build6_pressed():
	_deck_build(6)


func _on_player_btn_pressed():
	pass # Replace with function body.

func _deck_build(num):
	$glow.show()
	$glow.position = get_child(num - 1).position
