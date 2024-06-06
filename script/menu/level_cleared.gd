extends Control
@onready var anim = $Panel/AnimationPlayer
@onready var judul = $Panel/VBox/title
@onready var main = $"../level_controller"
@onready var star_sfx = $star
@onready var fail_sfx = $failed
@onready var click_sfx = $btn_click
@onready var hover_sfx = $btn_hover

var game_dijeda = false
var saveData = SaveData.new()
var chapter
var level
var clear
var level_data
var stars
var show = 0

func _ready():
	level_data = saveData.load_data()
	stars = level_data["ch_stars"][chapter][level]
	if stars == 0 :
		anim.play("b0")
	elif stars == 1 :
		anim.play("b1")
	elif stars == 2 :
		anim.play("b2")
	elif stars == 3 :
		anim.play("b3")
	clear = level_data["ch_clear"][chapter][level]
	print(clear)
	$Panel/VBox/CenterContainer/info_box.hide()
	$".".hide()

func level_failed():
	judul.text = "- ANDA GAGAL -"
	anim.play("b0")
	fail_sfx.play()
	$".".show()

func game_paused():
	judul.text = "- GAME DIJEDA -"
	$".".show()
	main.pause_game()
func game_resumed():
	judul.text = "- LEVEL SELESAI -"
	$".".hide()
	main.pause_game()
	
func jeda_game() :
	if game_dijeda:
		game_resumed()
	else:
		game_paused()
	game_dijeda = !game_dijeda

func bintang_1():
	anim.play("RESET")
	anim.play("b1")
	star_sfx.play()
	$".".show()

func bintang_2():
	anim.play("RESET")
	anim.play("b2")
	star_sfx.play()
	$".".show()

func bintang_3():
	anim.play("RESET")
	star_sfx.play()
	$".".show()

func _on_level_controller_is_less_than_1(val1):
	var less1 = $Panel/VBox/cons/con3/less1
	if val1 < 10 :
		less1.text = "<0%d" %val1
	else :
		less1.text = "<%d" %val1

func _on_level_controller_is_less_than_2(val2):
	var less2 = $Panel/VBox/cons/con2/less2
	if val2 < 10 :
		less2.text = "<0%d" %val2
	else :
		less2.text = "<%d" %val2

func set_info_txt(kata,arti) :
	$Panel/VBox/CenterContainer/info_box/Panel/kata.text = kata
	$Panel/VBox/CenterContainer/info_box/Panel/kbbi.text = arti


func _on_restart_lvl_pressed():
	click_sfx.play()
	game_dijeda = false
	judul.text = "- LEVEL SELESAI -"
	$".".hide()
	anim.play("RESET")
	main.restart()
func _on_back_to_lvl_select_pressed():
	click_sfx.play()
	MusicPlayer.bgm2_play()
	send_data()
	main.back_to_select()
func send_data():
	main.send_save(chapter,level,clear,stars)
func _on_next_lvl_pressed():
	click_sfx.play()
	send_data()
	main.next_lvl()

func _on_level_controller_ch_val(val3):
	chapter = val3
func _on_level_controller_lvl_val(val4):
	level = val4
func _on_level_controller_clear_val(val5):
	clear = val5
func _on_level_controller_star(x):
	stars = x

func _on_restart_lvl_mouse_entered():
	hover_sfx.play()
func _on_back_to_lvl_select_mouse_entered():
	hover_sfx.play()
func _on_next_lvl_mouse_entered():
	hover_sfx.play()
func _on_info_mouse_entered():
	hover_sfx.play()
func _on_info_pressed():
	click_sfx.play()
	if show == 0 :
		$Panel/VBox/CenterContainer/info_box.show()
		show = 1
	elif show == 1 :
		$Panel/VBox/CenterContainer/info_box.hide()
		show = 0
