extends ParallaxLayer

@export var BACKGROUND_SPEED : float = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	self.motion_offset.x += BACKGROUND_SPEED * delta
