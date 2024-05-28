extends Control
@onready var level = $Panel/level
@onready var click_sfx = $btn_click
@onready var hover_sfx = $btn_hover
var saveData = SaveData.new()
var GAME_DATA

func _ready():
	GAME_DATA = saveData.load_data()
	unlock_check()

func unlock_check():
	var x = 0
	var y
	var z
	while x < level.get_child_count() :
		y = GAME_DATA["ch_clear"][0][x]
		z = GAME_DATA["ch_stars"][0][x]
		if y == -1 : #PLAYED
			level.get_child(x).get_child(0).hide()
			level.get_child(x).get_child(1).text = "%d STARS" %z
		elif y == 0 : #NOT PLAYED
			level.get_child(x).get_child(0).hide()
			level.get_child(x).get_child(1).hide()
		elif y == 1 : #CLEARED
			level.get_child(x).get_child(0).hide()
			level.get_child(x).get_child(1).text = "%d STARS" %z
		elif y == 2 : #LOCKED
			level.get_child(x).disabled = true
			level.get_child(x).get_child(1).hide()
		x+=1

func _on_back_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/menu/chapter_select.tscn")
func _on_back_mouse_entered():
	hover_sfx.play()

func _on_level_1_pressed():
	click_sfx.play()
	MusicPlayer.stop()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_1_1.tscn")
func _on_level_1_mouse_entered():
	hover_sfx.play()
