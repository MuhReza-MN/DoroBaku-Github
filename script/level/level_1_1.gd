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
var level = 0 # = level 1
@onready var next_level_is = "res://scene/level/level_not.tscn"
@onready var select_target = "res://scene/level/chapter_1/level_select.tscn"
var lessThan1 = 35
var lessThan2 = 40
var maxMove = 55
# setel huruf (pastikan lowercase) , setel izin + j
var h1 = "i"
var h2 = "z"
var h3 = "n"
var h4 = "j"

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
	MusicPlayer.bgm3_play()
	box_setup()
	Engine.time_scale = 1

# wajib untuk disesuaikan untuk setiap level, sangat sensitif
func cek_nama(nama) :
	if h1 in nama :
		info = true
	elif h2 in nama :
		info = true
	elif h3 in nama :
		info = true

func box_setup() :
	# setel huruf yg ditampilkan (sangat penting untuk sesuai semua)
	get_tree().get_nodes_in_group("i")[0].set_block(h1)
	get_tree().get_nodes_in_group("z")[0].set_block(h2)
	get_tree().get_nodes_in_group("i")[1].set_block(h1)
	get_tree().get_nodes_in_group("n")[0].set_block(h3)
	get_tree().get_nodes_in_group("j")[0].set_block(h4)
# sampai sini setupnya

func pause_game():
	if game_paused:
		$menu.show()
		Engine.time_scale = 1
	else:
		$menu.hide()
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
			$menu.hide()
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
			game_end = true
			
		if moveCount > maxMove :
			$menu.hide()
			emit_signal("star",0)
			get_tree().get_nodes_in_group("scoreboard")[0].levelFailed()
			game_end = true

func _on_karakter_is_moving(bool):
	if bool:
		moveCount +=1
		print(moveCount)

func send_save(ch,lvl,clr,str):
	var cek = gameData["ch_clear"][chapter][level]
	if cek == 0 :
		if game_end == true :
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)
		else :
			saveData.edit_data_lvl_clear(ch,lvl,-1,str)
	elif cek == 1 :
		if game_end == true :
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)
	elif cek == -1 :
		if game_end == true :
			if str >= stars :
				saveData.edit_data_lvl_clear(ch,lvl,1,str)
			else :
				saveData.edit_data_lvl_clear(ch,lvl,1,stars)

# btn functions
func _on_pause_pressed():
	get_tree().get_nodes_in_group("scoreboard")[0].jeda_game()
func _on_reset_pressed():
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
