extends CharacterBody2D

#var settingan utama
var anim_speed = 3
var moving = false
var tile_size = 32
var inputs = {
	"up": Vector2.UP,
	"down": Vector2.DOWN,
	"left": Vector2.LEFT,
	"right": Vector2.RIGHT,
}

signal isMoving(bool)
@onready var ray = $RayCast2D
@onready var anim = $AnimationPlayer

func _unhandled_input(event):
	if moving:
		return
		
	for dir in inputs.keys():
		if event.is_action_pressed(dir):
			move(dir)

func move(dir):
	ray.target_position = inputs[dir] * tile_size
	ray.force_raycast_update()
	
	if !ray.is_colliding():
		var tween = create_tween()
		tween.tween_property(self, "position",
			position + inputs[dir] * tile_size,
			1.0/anim_speed).set_trans(Tween.TRANS_SINE)
		moving = true
		emit_signal("isMoving",true)
		$AnimationPlayer.play(dir)
		await tween.finished
		moving = false
		emit_signal("isMoving",false)
	else:
		var collider = ray.get_collider()
		if collider.is_in_group('kotak'):
			if collider.move(dir):
				var tween = create_tween()
				tween.tween_property(self, "position",
					position + inputs[dir] * tile_size,
					1.0/anim_speed).set_trans(Tween.TRANS_SINE)
				moving = true
				emit_signal("isMoving",true)
				$AnimationPlayer.play(dir)
				await tween.finished
				moving = false
				emit_signal("isMoving",false)
