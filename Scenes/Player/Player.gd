extends KinematicBody2D

const GRAVITY = 25
const JUMP_FORCE := 400

var velocity = Vector2.ZERO
onready var move_speed : float = 175 * scale.x

# Called when the node enters the scene tree for the first time.
func _physics_process(_delta):
    var move_left = Input.get_action_strength("ui_left")
    var move_right = Input.get_action_strength("ui_right")
    
    velocity.x = (move_right - move_left) * move_speed
    velocity.y += GRAVITY

    velocity = move_and_slide(velocity, Vector2.UP)

    if move_left > 0:
      $AnimatedSprite.flip_h = true
    elif move_right > 0:
      $AnimatedSprite.flip_h = false

    if velocity.y > 0:
      $AnimatedSprite.play("jump")
    elif velocity.y < 0:
      $AnimatedSprite.play("fall")
    elif velocity.x != 0:
      $AnimatedSprite.play("run")
    else:
      $AnimatedSprite.play("idle")

func _input(event):
  if event.is_action_pressed("ui_accept") and is_on_floor():
    velocity.y -= JUMP_FORCE
    
