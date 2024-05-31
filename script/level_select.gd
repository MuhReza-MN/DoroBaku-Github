extends Control
@onready var ch1 = $Panel/ch1
@onready var ch2 = $Panel/ch2
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
	while x < ch1.get_child_count() :
		y = GAME_DATA["ch_clear"][0][x]
		z = GAME_DATA["ch_stars"][0][x]
		if y == -1 : #PLAYED
			ch1.get_child(x).get_child(1).show()
			ch1.get_child(x).get_child(2).hide()
			ch1.get_child(x).get_child(3).hide()
			ch1.get_child(x).get_child(4).hide()
		elif y == 0 : #NOT PLAYED
			ch1.get_child(x).get_child(1).show()
			ch1.get_child(x).get_child(2).hide()
			ch1.get_child(x).get_child(3).hide()
			ch1.get_child(x).get_child(4).hide()
		elif y == 1 : #CLEARED
			ch1.get_child(x).get_child(1).hide()
			ch1.get_child(x).get_child(2).hide()
			ch1.get_child(x).get_child(3).hide()
			ch1.get_child(x).get_child(4).hide()
			if z == 1 :
				ch1.get_child(x).get_child(2).show()
			elif z == 2 :
				ch1.get_child(x).get_child(3).show()
			elif z == 3 :
				ch1.get_child(x).get_child(4).show()
		elif y == 2 : #LOCKED
			ch1.get_child(x).disabled = true
			ch1.get_child(x).get_child(1).hide()
			ch1.get_child(x).get_child(2).hide()
			ch1.get_child(x).get_child(3).hide()
			ch1.get_child(x).get_child(4).hide()
		x+=1
	x = 0
	while x < ch2.get_child_count() :
		y = GAME_DATA["ch_clear"][1][x]
		z = GAME_DATA["ch_stars"][1][x]
		if y == -1 : #PLAYED
			ch2.get_child(x).get_child(1).show()
			ch2.get_child(x).get_child(2).hide()
			ch2.get_child(x).get_child(3).hide()
			ch2.get_child(x).get_child(4).hide()
		elif y == 0 : #NOT PLAYED
			ch2.get_child(x).get_child(1).show()
			ch2.get_child(x).get_child(2).hide()
			ch2.get_child(x).get_child(3).hide()
			ch2.get_child(x).get_child(4).hide()
		elif y == 1 : #CLEARED
			ch2.get_child(x).get_child(1).hide()
			ch2.get_child(x).get_child(2).hide()
			ch2.get_child(x).get_child(3).hide()
			ch2.get_child(x).get_child(4).hide()
			if z == 1 :
				ch2.get_child(x).get_child(2).show()
			elif z == 2 :
				ch2.get_child(x).get_child(3).show()
			elif z == 3 :
				ch2.get_child(x).get_child(4).show()
		elif y == 2 : #LOCKED
			ch2.get_child(x).disabled = true
			ch2.get_child(x).get_child(1).hide()
			ch2.get_child(x).get_child(2).hide()
			ch2.get_child(x).get_child(3).hide()
			ch2.get_child(x).get_child(4).hide()
		x+=1

func _on_back_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/menu/main_menu.tscn")
func _on_next_page_pressed():
	click_sfx.play()
func _on_back_mouse_entered():
	hover_sfx.play()

func _on_level_1_mouse_entered(): #all lvl btn connected
	hover_sfx.play()
func _on_level_1_pressed():
	click_sfx.play()
	MusicPlayer.stop()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_1_1.tscn")
func _on_level_2_pressed():
	click_sfx.play()
	MusicPlayer.stop()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_1_2.tscn")
func _on_level_3_pressed():
	click_sfx.play()
	MusicPlayer.stop()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_1_3.tscn")
