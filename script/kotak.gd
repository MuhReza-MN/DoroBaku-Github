extends CharacterBody2D
 
@onready var huruf = $Sprite2D
@onready var ray = $RayCast2D
@onready var anim = $AnimationPlayer

var anim_speed = 3
var tile_size = 32
var inputs = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
}

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size,
			1.0/anim_speed).set_trans(Tween.TRANS_SINE)
		return true
	return false

func set_block(huruf):
	anim.play(huruf)

