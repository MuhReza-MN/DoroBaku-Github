extends Control
@onready var ch = $Panel/chapter
var saveData = SaveData.new()
var GAME_DATA

func _ready():
	GAME_DATA = saveData.load_data()
	unlock_check()

func unlock_check():
	var x = 0
	var y
	while x < ch.get_child_count() :
		y = GAME_DATA["ch_open"][x]
		if y == 0 : # LOCKED
			ch.get_child(x).disabled = true
		elif y == 1 : # UNLOCKED
			ch.get_child(x).get_child(0).hide()
			ch.get_child(x).get_child(2).hide()
		x+=1

func _on_back_pressed():
	get_tree().change_scene_to_file("res://scene/menu/main_menu.tscn")
func _on_ch_1_pressed():
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_select.tscn")
