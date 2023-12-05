extends CharacterBody2D


const GRAVITY : int = 1000
const MAX_VEL : int = 600
const FLAP_SPEED : int = -350
var flying : bool = false
var falling : bool = false
var START_POS : Vector2

var screen_size = Vector2(0,0)

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size.x = get_viewport().get_visible_rect().size.x # Get Width
	screen_size.y = get_viewport().get_visible_rect().size.y # Get Height
	START_POS = Vector2(screen_size.x / 5, screen_size.y / 2)
	reset()
	
func reset(): 
	falling = false
	flying = false
	position = START_POS
	set_rotation(0)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if flying or falling:
		velocity.y += GRAVITY * delta
		
		# Terminal velocity
		if velocity.y > MAX_VEL:
			velocity.y = MAX_VEL
		if flying: 
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()
		
func flap():
	velocity.y = FLAP_SPEED
