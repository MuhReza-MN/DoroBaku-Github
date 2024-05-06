extends Area2D

@onready var anim = $AnimationPlayer
var occupied = false 
var exited = false
var nama_kotak
var nama_cek

func _ready():
	anim.play("standby")
	set_collision_layer_value(1,false)

func _on_body_entered(body):
	await get_tree().create_timer(0.15).timeout
	if body.is_in_group("kotak") :
		occupied = true
		nama_kotak = body.name
		nama_cek = name

func _on_body_exited(body):
	if body.is_in_group("kotak") :
		occupied = false
		exited = true
		nama_kotak = body.name
		nama_cek = name
		await get_tree().create_timer(0.1).timeout
		exited = false

