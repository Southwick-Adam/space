extends Node2D

export (PackedScene) var Build

onready var inventory = get_node("/root/main/CanvasLayer/UI/inventory")

var build_mode = false

var music = true
var sound = true

#INVENTORY
func _on_pack_pressed():
	inventory.visible = !inventory.visible

#SETTINGS
func _on_settings_pressed():
	var icons = [$pause, $sound, $music, $pack, $build_btn]
	for child in icons:
		if child != $settings:
			child.visible = !child.visible

func _on_pause_pressed():
	$play.show()

func _on_sound_pressed():
	if sound:
		$sound/Sprite.texture = preload("res://assets/UI/icons/nosound.png")
	else:
		$sound/Sprite.texture = preload("res://assets/UI/icons/sound.png")
	sound = !sound

func _on_music_pressed():
	if music:
		$music/Sprite.texture = preload("res://assets/UI/icons/nomusic.png")
	else:
		$music/Sprite.texture = preload("res://assets/UI/icons/music.png")
	music = !music

func _on_play_pressed():
	$play.hide()

func _on_build_btn_pressed():
	if build_mode:
		$build.queue_free()
	else:
		var node = Build.instance()
		add_child(node)
	build_mode = !build_mode

func _on_Area2D_mouse_entered():
	get_node("/root/main").mouse_stop = true

func _on_Area2D_mouse_exited():
	get_node("/root/main").mouse_stop = false
