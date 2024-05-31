extends Resource
class_name SaveData
var SAVE_PATH = "user://game.save"

func edit_data_lvl_clear(chapter, level, clear, star):
	var GAME_DATA = load_game()
	GAME_DATA["ch_clear"][chapter][level] = clear
	GAME_DATA["ch_stars"][chapter][level] = star
	save_game(GAME_DATA)

func save_data(): # default
	# keterangan :
	# ch_open : 0 = locked, 1 = unlocked
	# ch*_stars : jumlah bintang 0 - 3
	# ch*_clear : 0 = blm , 1 = sudah, 2 = locked , -1 = played
	var GAME_DATA = {
		ch_open = [1,0,0,0,0,0,0,0,0,0],
		ch_stars = [
		# chapter 1
		[0,0,0,0,0,0,0,0,0,0,0,0],
		# chapter 2
		[0,0,0,0,0,0,0,0,0,0,0,0]
		],
		ch_clear = [
		# chapter 1
		[0,2,2,2,2,2,2,2,2,2,2,2],
		# chapter 2
		[2,2,2,2,2,2,2,2,2,2,2,2]
		]
	} 
	return GAME_DATA

func save_game(save_write):
	var save_file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.WRITE, "9071")
	var json_string = JSON.stringify(save_write)
	save_file.store_line(json_string)

func load_game():
	var GAME_DATA
	if !FileAccess.file_exists(SAVE_PATH):
		save_game(save_data())
		print("savedata created")
		return
	var save_file = FileAccess.open_encrypted_with_pass(SAVE_PATH, FileAccess.READ, "9071")
	while save_file.get_position() < save_file.get_length():
		var json_string = save_file.get_line()
		var json = JSON.new()
		var parse_result = json.parse(json_string)
		GAME_DATA = json.get_data()
	return GAME_DATA

func load_data():
	var GAME_DATA = load_game()
	#for i in GAME_DATA["ch_clear"][0] :
		#print (i)
	return GAME_DATA

