extends Area2D

# optional “setget” keyword = set_func[, get_func]
export (bool) var is_active := false setget set_active

func set_active(new_value):
  is_active = new_value

  if is_active:
    $AnimatedSprite.play("activating")
  else:
    # second arg is an optional “play backwards” flag
    $AnimatedSprite.play("activating", true)
