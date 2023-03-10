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
  var on_wall_or_ledge = is_on_wall() or not $RayCast2D.is_colliding()
  if is_alive and on_wall_or_ledge:
    turn_around()

func turn_around():
  scale.x *= -1
  move_speed *= -1

func _on_HitArea2D_body_entered(body):
  if body.has_method("take_enemy_damage"):
    body.take_enemy_damage()

func _on_ShellArea2D_body_entered(body):
  if is_alive:
    is_alive = false
  
    if body.has_method("bounce"): body.bounce()
    
    set_collision_layer_bit(0, false)
    set_collision_mask_bit(0, false)
    $HitArea2D.set_collision_layer_bit(0, false)
    $HitArea2D.set_collision_mask_bit(0, false)
    $ShellArea2D.set_collision_layer_bit(0, false)
    $ShellArea2D.set_collision_mask_bit(0, false)
    $HitAudioStreamPlayer2D.play()
    velocity.y -= DEFEATED_BOUNCE_FORCE
    $AnimatedSprite.play("defeated")
    yield(get_tree().create_timer(1), "timeout")
    queue_free()
