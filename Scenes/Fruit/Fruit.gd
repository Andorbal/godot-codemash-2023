tool extends Area2D
export (String, "Banana", "Strawberry") var fruit = "Banana" setget set_fruit
onready var ANIMATED_SPRITE := $AnimatedSprite
var collected : bool = false

func set_fruit(new_value:String):
  fruit = new_value
  $AnimatedSprite.play(fruit.to_lower())

func _on_Fruit_body_entered(body):
  if not collected and body.has_method("collect_fruit"):
    collected = true
    body.collect_fruit(fruit.to_lower())
    ANIMATED_SPRITE.play("poof")
    $AudioStreamPlayer2D.play()

func _on_AnimatedSprite_animation_finished():
  if $AnimatedSprite.animation == "poof": 
    visible = false
