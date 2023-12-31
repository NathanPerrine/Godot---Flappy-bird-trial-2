extends Node2D

#@export var pipe_scene : PackedScene
@onready var pipe_scene = preload("res://scenes/pipes.tscn")

var game_running : bool
var game_over : bool
var scroll
var score
const SCROLL_SPEED : int = 1
var screen_size : Vector2i
var ground_height : int
var pipes : Array
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size
	
	#ground_height = $Ground.get_node("Sprite2D").texture.get_height()
	
	new_game()


func new_game():
	# Reset variables
	game_running = false
	game_over = false
	score = 0
	scroll = 0
	
	
	#pipes.clear()
	get_tree().call_group("pipes", "queue_free")
	
	
	
	$Bird.reset()
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)
	$BetterGround.scroll_speed = 0.5
	$GameOver.hide()


func _input(event):
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()
						check_top()


func start_game():
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()
	$ParallaxBackground/ParallaxLayer.BACKGROUND_SPEED = -15
	$BetterGround.scroll_speed = SCROLL_SPEED
	generate_pipes()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	if game_running:
		scroll += SCROLL_SPEED
		
		# Reset scroll
		#if scroll >= screen_size.x:
			#scroll = 0
		
		# Move ground node
		#$Ground.position.x = -scroll
		
		#$BetterGround.scroll_base_offset.x = -scroll
		#$BetterGround.scroll_speed = SCROLL_SPEED
		
		# Move pipes
		#for pipe in pipes:
			#pipe.position.x -= SCROLL_SPEED
			
		# Move ground


func _on_pipe_timer_timeout():
	#pass
	generate_pipes()


func generate_pipes():
	var pipe = pipe_scene.instantiate()
	add_child(pipe)
	pipe.scroll_speed = 1.0
	pipe.spawn_pipes("yellow")
	pipe.scored.connect(scored)
	pipes.append(pipe)
	
	#pipe.hit.connect(bird_hit)


func check_top():
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()


func stop_game():
	$PipeTimer.stop()
	$GameOver.show()
	$Bird.flying = false
	game_running = false
	game_over = true
	$ParallaxBackground/ParallaxLayer.BACKGROUND_SPEED = 0
	$BetterGround.scroll_speed = 0
	get_tree().call_group("pipes", "stop")


func bird_hit():
	$Bird.falling = true
	stop_game()


func _on_ground_hit():
	$Bird.falling = false
	stop_game()


func scored():
	score += 1
	$CanvasLayer/ScoreLabel.text = "Score: " + str(score)


func _on_game_over_restart():
	new_game()


func _on_better_ground_hit():
	$Bird.falling = true
	stop_game()


func _on_bird_hit_wall():
	$Bird.falling = true
	stop_game()
