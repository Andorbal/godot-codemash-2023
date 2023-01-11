extends KinematicBody2D

const DEFEATED_BOUNCE_FORCE := 250  # will be used soon
const GRAVITY = 25
onready var move_speed : float = 35 * scale.x
var is_alive := true  # will be used soon
var velocity = Vector2.ZERO

func _physics_process(_delta):
  if is_alive: 
    velocity.x = -move_speed

  velocity.y += GRAVITY
  velocity = move_and_slide(velocity, Vector2.UP)

  if is_alive and velocity.x != 0: $AnimatedSprite.play("walk")
  if is_alive and is_on_wall():
    turn_around()

func turn_around():
  scale.x *= -1
  move_speed *= -1

func _on_HitArea2D_body_entered(body):
  if body.has_method("take_enemy_damage"):
    body.take_enemy_damage()
