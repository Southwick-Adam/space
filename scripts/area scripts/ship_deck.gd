extends Area2D

onready var main = get_node("/root/main")

func _on_Area2D_mouse_entered():
	main.mouse_pos.append(self)

func _on_Area2D_mouse_exited():
	main.mouse_pos.erase(self)
