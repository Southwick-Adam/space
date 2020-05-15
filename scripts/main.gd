extends Node2D

var mouse_pos = [] #ARAY OF LANDS SELECTED

func _input(event):
	if event.is_action_pressed(("click")) and not mouse_pos.empty() and $player.line_out == false:
		var mark = Position2D.new()
		mouse_pos.back().add_child(mark)
		mark.global_position = get_global_mouse_position()
		if mark.get_parent() == $player.current_land:
			$player._move("walk", mark)
		else:
			$player._zip(mark)
			
