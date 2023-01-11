extends KinematicBody2D

signal fruit_collected

const GRAVITY = 25
const JUMP_FORCE := 400

var respawn_checkpoint_node_ref : Node2D
var velocity = Vector2.ZERO
onready var move_speed : float = 175 * scale.x
onready var start_position = global_position

var collected_fruit := {}

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
    $JumpSound.play()
    
func update_checkpoint(new_checkpoint : Node2D):
  if respawn_checkpoint_node_ref == new_checkpoint:
    return
  
  if respawn_checkpoint_node_ref != null:
    respawn_checkpoint_node_ref.set_active(false)

  respawn_checkpoint_node_ref = new_checkpoint
  respawn_checkpoint_node_ref.set_active(true)

func take_spike_damage() -> void:
  respawn()

func respawn():
  if respawn_checkpoint_node_ref != null:
    global_position = respawn_checkpoint_node_ref.global_position
  else:
    global_position = start_position

func collect_fruit(fruit:String) -> void:
  if not collected_fruit.has(fruit):
    collected_fruit[fruit] = 0
  collected_fruit[fruit] += 1
  emit_signal("fruit_collected", collected_fruit)
