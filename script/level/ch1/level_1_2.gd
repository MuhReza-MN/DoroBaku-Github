extends Node2D
var saveData = SaveData.new()
@onready var anim = $"../AnimationPlayer"
#settingan Level
var moveCount = 0
var info = false
var game_end = false
var game_paused = false
signal isLessThan_1(val1)
signal isLessThan_2(val2)
signal ch_val(val3)
signal lvl_val(val4)
signal clear_val(val5)
signal star(x)
var gameData
var stars

# wajib disetel
var chapter = 0 # = chapter 1
var level = 1 # = level 2
var next_lvl_val = 2 # = level 3
@onready var next_level_is = "res://scene/level/chapter_1/level_1_3.tscn"
@onready var select_target = "res://scene/level/chapter_1/level_select.tscn"
var lessThan1 = 60
var lessThan2 = 70
var maxMove = 80
# setel huruf (pastikan lowercase) , setel afdal + o
var h1 = "a"
var h2 = "f"
var h3 = "d"
var h4 = "l"
var h5 = "o"
# setel text info (enter tetap terbaca)
var kata = "- AFDAL -"
var arti = "lebih baik; lebih utama;
			lengkap; komplet:"

func _ready():
	gameData = saveData.load_data()
	# mengirim sinyal
	emit_signal("isLessThan_1",lessThan1)
	emit_signal("isLessThan_2",lessThan2)
	emit_signal("ch_val",chapter)
	emit_signal("lvl_val",level)
	emit_signal("clear_val",gameData["ch_clear"][chapter][level])
	stars = gameData["ch_stars"][chapter][level]
	#setup stage
	box_setup()
	get_tree().get_nodes_in_group("scoreboard")[0].set_info_txt(kata,arti)
	Engine.time_scale = 1

# wajib untuk disesuaikan untuk setiap level, sangat sensitif
func cek_nama(nama) :
	if h1 in nama :
		info = true
	elif h2 in nama :
		info = true
	elif h3 in nama :
		info = true
	elif h4 in nama :
		info = true

func box_setup() :
	# setel huruf yg ditampilkan (sangat penting untuk sesuai semua)
	get_tree().get_nodes_in_group("a")[0].set_block(h1)
	get_tree().get_nodes_in_group("f")[0].set_block(h2)
	get_tree().get_nodes_in_group("d")[0].set_block(h3)
	get_tree().get_nodes_in_group("a")[1].set_block(h1)
	get_tree().get_nodes_in_group("l")[0].set_block(h4)
	get_tree().get_nodes_in_group("o")[0].set_block(h5)
# sampai sini setupnya

func pause_game():
	if game_paused:
		$Camera2D/menu.show()
		Engine.time_scale = 1
	else:
		$Camera2D/menu.hide()
		Engine.time_scale = 0
	game_paused = !game_paused

func _process(delta):
	if game_end == false:
		var target = $grup_cek.get_child_count()
		var cek_keluar = false
		for i in $grup_cek.get_children():
			if i.occupied:
				cek_nama(i.nama_kotak)
				if info :
					if i.nama_kotak in i.nama_cek :
						target -= 1
						cek_keluar = true
				info = false
			if i.exited :
				cek_nama(i.nama_kotak)
				if info :
					if cek_keluar :
						target += 1
				info = false
		if target == 0:
			$Camera2D/menu.hide()
			if moveCount <= lessThan1 :
				emit_signal("star",3)
				await get_tree().create_timer(0.1).timeout
				get_tree().get_nodes_in_group("scoreboard")[0].bintang_3()
			elif moveCount <= lessThan2 :
				emit_signal("star",2)
				await get_tree().create_timer(0.1).timeout
				get_tree().get_nodes_in_group("scoreboard")[0].bintang_2()
			else  :
				emit_signal("star",1)
				await get_tree().create_timer(0.1).timeout
				get_tree().get_nodes_in_group("scoreboard")[0].bintang_1()
			$"../bgm".stop()
			game_end = true
			
		if moveCount > maxMove :
			$Camera2D/menu.hide()
			emit_signal("star",0)
			get_tree().get_nodes_in_group("scoreboard")[0].levelFailed()
			$"../bgm".stop()
			game_end = true

func _on_karakter_is_moving(bool):
	if bool:
		moveCount +=1
		print(moveCount)

func send_save(ch,lvl,clr,str):
	var cek = gameData["ch_clear"][chapter][level]
	if cek == 0 :
		if game_end == true :
			saveData.edit_data_lvl_clear(chapter,next_lvl_val,0,0)
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)
		else :
			saveData.edit_data_lvl_clear(ch,lvl,-1,str)
	elif cek == 1 :
		if game_end == true :
			saveData.edit_data_lvl_clear(chapter,next_lvl_val,0,0)
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)
	elif cek == -1 :
		if game_end == true :
			saveData.edit_data_lvl_clear(chapter,next_lvl_val,0,0)
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)

# btn functions
func _on_pause_pressed():
	$"../btn_click".play()
	get_tree().get_nodes_in_group("pause_menu")[0].jeda_game()
func _on_reset_pressed():
	$"../btn_click".play()
	restart()
func restart():
	game_end = false
	game_paused = false
	Engine.time_scale = 1
	get_tree().reload_current_scene()
func next_lvl():
	get_tree().change_scene_to_file(next_level_is)
func back_to_select():
	get_tree().change_scene_to_file(select_target)


func _on_pause_mouse_entered():
	$"../btn_hover".play()
func _on_reset_mouse_entered():
	$"../btn_hover".play()
