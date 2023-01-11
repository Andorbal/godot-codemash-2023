extends KinematicBody2D

var velocity = Vector2.ZERO
onready var move_speed : float = 175 * scale.x

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
    var move_left = Input.get_action_strength("ui_left")
    var move_right = Input.get_action_strength("ui_right")
    velocity.x = (move_right - move_left) * move_speed

    var move_up = Input.get_action_strength("ui_up")
    var move_down = Input.get_action_strength("ui_down")
    velocity.y = (move_down - move_up) * move_speed

    velocity = move_and_slide(velocity, Vector2.UP)

