extends Control
var saveData = SaveData.new()

func _ready():
	MusicPlayer.bgm2_play()
	saveData.load_data()

func _on_mulai_pressed():
	get_tree().change_scene_to_file("res://scene/menu/chapter_select.tscn")

func _on_keluar_pressed():
	get_tree().quit()


func _on_save_pressed():
	saveData.save_game(saveData.save_data())
func _on_load_pressed():
	var datas = saveData.load_data()
	var x = 0
	while x < len(datas["ch_stars"][0]) :
		print(str(x) , ". " , datas["ch_stars"][0][x])
		x+=1
func _on_change_pressed():
	saveData.edit_data_lvl_clear(0,0,-1,2)
