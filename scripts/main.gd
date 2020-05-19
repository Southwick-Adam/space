extends Node2D

var mouse_pos = [] #ARAY OF LANDS UNDER MOUSE
var gun = null
var mark = null
var target_land
var mouse_stop = false

func _input(event):
	if event.is_action_pressed(("click")) and not mouse_pos.empty() and not mouse_stop:
		if gun == null:
			if not $player.line_out:
				_mark()
				if mark.get_parent() == $player.current_land:
					$player._move("walk", mark)
				else:
					target_land = mark.get_parent()
					$player._zip(mark)
#GUN
		else:
			if not gun.chain_out:
				_mark()
				gun._shoot(mark)
				target_land = mark.get_parent()

func _mark():
	if mark != null:
		mark.queue_free()
	mark = Position2D.new()
	mark.name = ("mark")
	mouse_pos.back().add_child(mark)
	mark.global_position = get_global_mouse_position()

#func _erase_mark():
#	target_land = null
#	mark = null
