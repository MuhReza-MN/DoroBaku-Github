extends AudioStreamPlayer

var bgm1 = load("res://asset/sound/bgm1.mp3")
var bgm2 = load("res://asset/sound/bgm2.mp3")
var bgm3 = load("res://asset/sound/bgm3.mp3")

func bgm1_play() -> void:
	stream = bgm1
	autoplay = true
	play()

func bgm2_play() -> void:
	stream = bgm2
	autoplay = true
	play()
	
func bgm3_play() -> void:
	stream = bgm3
	autoplay = true
	play()
	
func bgm_stop() -> void:
	stop()
