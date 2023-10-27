extends Area2D
@export var speed = 3 # How fast the player will move (pixels/sec).

signal hit
signal big_move(new_target: Vector2)
signal get_score_value(amt)
var screen_size # Size of the game window.
var target := Vector2.ZERO

func _ready():
	screen_size = get_viewport_rect().size


func _process(delta):
	if (position.distance_to(target) > 150):
#        print("big_move!")
		big_move.emit(target)

	position = position.lerp(target, 0.9 * speed * delta)
	pass

func set_target(t: Vector2):
	target = t
	

func _on_body_entered(body):
	# 
	# hit.emit()

	if(body.is_in_group("food")):
		get_score_value.emit(1)
#	else:
#		hide()
#		$CollisionShape2D.set_deferred("disabled", true)
#        queue_free()
	body.call_me()

	# print_debug(body.name == "Mob")
	# Must be deferred as we can't change physics properties on a physics callback.
	# $CollisionShape2D.set_deferred("disabled", true)
	pass # Replace with function body.
