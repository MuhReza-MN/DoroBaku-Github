extends Control
var saveData = SaveData.new()
@onready var click_sfx = $btn_click
@onready var hover_sfx = $btn_hover

func _ready():
	MusicPlayer.bgm2_play()
	saveData.load_data()
	
func _unhandled_key_input(event):
	if event.is_pressed():
		click_sfx.play()
		get_tree().change_scene_to_file("res://scene/menu/main_menu.tscn")

func _on_mulai_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/menu/main_menu.tscn")


func _on_save_pressed():
	click_sfx.play()
	saveData.save_game(saveData.save_data())
func _on_load_pressed():
	click_sfx.play()
	var datas = saveData.load_data()
	var x = 0
	while x < len(datas["ch_stars"][0]) :
		print(str(x) , ". " , datas["ch_stars"][0][x])
		x+=1
func _on_change_pressed():
	click_sfx.play()
	saveData.edit_data_lvl_clear(0,0,-1,2)


func _on_mulai_mouse_entered():
	hover_sfx.play()
func _on_save_mouse_entered():
	hover_sfx.play()
func _on_load_mouse_entered():
	hover_sfx.play()
func _on_change_mouse_entered():
	hover_sfx.play()
