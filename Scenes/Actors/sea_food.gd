extends CharacterBody2D

const SPEED = 10.0
#const JUMP_VELOCITY = -400.0
var noise = FastNoiseLite.new()
var timer = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
    # Add the gravity.
#    if not is_on_floor():
#        velocity.y += gravity * delta
#
#    # Handle Jump.
#    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#        velocity.y = JUMP_VELOCITY
#
#    # Get the input direction and handle the movement/deceleration.
#    # As good practice, you should replace UI actions with custom gameplay actions.
#    var direction = Input.get_axis("ui_left", "ui_right")
#    if direction:
#        velocity.x = direction * SPEED
#    else:
#        velocity.x = move_toward(velocity.x, 0, SPEED)
#    var velocity = Vector2.ZERO
    timer += delta
    velocity.x = noise.get_noise_2d(timer * 30,timer * 30)
    velocity.y = noise.get_noise_2d(timer* 20,timer * 20)
    velocity.y += 0.4
    velocity = velocity.normalized() * SPEED
#    position += velocity * delta
    move_and_slide()

func call_me():
    queue_free()
    
