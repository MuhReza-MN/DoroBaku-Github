extends Control
var saveData = SaveData.new()
@onready var click_sfx = $btn_click
@onready var hover_sfx = $btn_hover

func _ready():
	saveData.load_data()

func _on_mulai_pressed():
	click_sfx.play()
	get_tree().change_scene_to_file("res://scene/level/chapter_1/level_select.tscn")

func _on_keluar_pressed():
	click_sfx.play()
	get_tree().quit()

func _on_mulai_mouse_entered():
	hover_sfx.play()
func _on_keluar_mouse_entered():
	hover_sfx.play()


func _on_settings_pressed():
	click_sfx.play()
func _on_settings_mouse_entered():
	hover_sfx.play()


func _on_kredit_pressed():
	click_sfx.play()
func _on_kredit_mouse_entered():
	hover_sfx.play()


func _on_baju_pressed():
	click_sfx.play()
func _on_baju_mouse_entered():
	hover_sfx.play()
