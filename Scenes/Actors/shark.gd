extends CharacterBody2D


@export var SPEED = 300.0
@export var SEEK_SPEED = 300.0
@export var TURN_SPEED = 1.0
@export var GROW_VAL = 1.05
# const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var state_timer: float = 0
enum {SEEKING, SWIMMING, TURNING}
var current_state = SWIMMING
var seek_target: Vector2 = Vector2.ZERO

func _physics_process(delta):
    var forward = Vector2.from_angle($Sprite2D.transform.get_rotation())
    
    match current_state:
        SEEKING:
#            print("seek")
            var new_forward = (seek_target - position).normalized()
            var angle_change = forward.angle_to(new_forward)
            $Sprite2D.transform = $Sprite2D.transform.rotated(angle_change * delta * TURN_SPEED)
            $CollisionShape2D.transform = $CollisionShape2D.transform.rotated(angle_change * delta * TURN_SPEED)
#            forward = forward.rotated()
            
            state_timer -= delta
            if (state_timer <= 0):
                current_state = SWIMMING

            position += forward * SEEK_SPEED * delta
        SWIMMING:
            position += forward * SPEED * delta
        TURNING:
            print("turn")

func call_me():
    transform = transform.scaled(Vector2(GROW_VAL, GROW_VAL))
    $Sprite2D.transform = $Sprite2D.transform.scaled(Vector2(GROW_VAL, GROW_VAL))
    $CollisionShape2D.transform = $CollisionShape2D.transform.scaled(Vector2(GROW_VAL, GROW_VAL))
    SPEED *= GROW_VAL
    SEEK_SPEED += GROW_VAL
    pass

func set_seek(new_target: Vector2):
    current_state = SEEKING
    state_timer = 2
    seek_target = new_target

func set_new_target(t: Vector2):
    pass
