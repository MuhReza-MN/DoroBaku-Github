extends Control
@onready var ch = $Panel/chapter
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
	while x < ch.get_child_count() :
		y = GAME_DATA["ch_open"][x]
		if y == 0 : # LOCKED
			ch.get_child(x).disabled = true
		elif y == 1 : # UNLOCKED
			ch.get_child(x).get_child(0).hide()
			ch.get_child(x).get_child(2).hide()
		x+=1

func _on_back_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/menu/main_menu.tscn")
func _on_back_mouse_entered():
	hover_sfx.play()
	
func _on_ch_1_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_select.tscn")
func _on_ch_1_mouse_entered():
	hover_sfx.play()
