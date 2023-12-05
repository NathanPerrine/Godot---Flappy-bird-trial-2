extends TileMap

signal hit
signal scored

func spawn_pipes(color : String = "green"):	
	# Upper pipe section
	var pipe_middle : Vector2i
	var pipe_upper_cap : Vector2i
	var pipe_upper_shadow : Vector2i
	
	# Lower pipe section
	var pipe_lower_cap : Vector2i
	var pipe_lower_shadow : Vector2i
	
	match color.to_lower():
		"green":
			pipe_middle 		= Vector2i(0, 2)
			pipe_upper_cap 		= Vector2i(0, 4)
			pipe_upper_shadow 	= Vector2i(0, 3)
			pipe_lower_cap 		= Vector2i(0, 0)
			pipe_lower_shadow 	= Vector2i(0, 1)
		"yellow":
			pipe_middle 		= Vector2i(1, 2)
			pipe_upper_cap 		= Vector2i(1, 4)
			pipe_upper_shadow 	= Vector2i(1, 3)
			pipe_lower_cap		= Vector2i(1, 0)
			pipe_lower_shadow 	= Vector2i(1, 1)
		"red":
			pipe_middle		 	= Vector2i(2, 2)
			pipe_upper_cap 		= Vector2i(2, 4)
			pipe_upper_shadow 	= Vector2i(2, 3)
			pipe_lower_cap		= Vector2i(2, 0)
			pipe_lower_shadow 	= Vector2i(2, 1)
		"blue":
			pipe_middle		 	= Vector2i(3, 2)
			pipe_upper_cap 		= Vector2i(3, 4)
			pipe_upper_shadow 	= Vector2i(3, 3)
			pipe_lower_cap		= Vector2i(3, 0)
			pipe_lower_shadow 	= Vector2i(3, 1)
		"white":
			pipe_middle		 	= Vector2i(0, 7)
			pipe_upper_cap 		= Vector2i(0, 9)
			pipe_upper_shadow 	= Vector2i(0, 8)
			pipe_lower_cap		= Vector2i(0, 5)
			pipe_lower_shadow 	= Vector2i(0, 6)
		"purple":
			pipe_middle		 	= Vector2i(1, 7)
			pipe_upper_cap 		= Vector2i(1, 9)
			pipe_upper_shadow 	= Vector2i(1, 8)
			pipe_lower_cap		= Vector2i(1, 5)
			pipe_lower_shadow 	= Vector2i(1, 6)
		"brown":
			pipe_middle		 	= Vector2i(2, 7)
			pipe_upper_cap 		= Vector2i(2, 9)
			pipe_upper_shadow 	= Vector2i(2, 8)
			pipe_lower_cap		= Vector2i(2, 5)
			pipe_lower_shadow 	= Vector2i(2, 6)
		"orange":
			pipe_middle		 	= Vector2i(3, 7)
			pipe_upper_cap 		= Vector2i(3, 9)
			pipe_upper_shadow 	= Vector2i(3, 8)
			pipe_lower_cap		= Vector2i(3, 5)
			pipe_lower_shadow 	= Vector2i(3, 6)
	
	# Set top pipe
	var randRangeTop = randi_range(1,15)
	
	for i in range(randRangeTop):
		# Upper pipe middle section
		set_cell(0, Vector2i(7, i), 0, pipe_middle, 0)
	
	# Upper pipe shadow
	set_cell(0, Vector2i(7, randRangeTop), 0, pipe_upper_shadow, 0)
	# Upper pipe cap
	set_cell(0, Vector2i(7, randRangeTop + 1), 0, pipe_upper_cap, 0)
	
	# Set botton pipe
	set_cell(0, Vector2i(7, randRangeTop + 8), 0, pipe_lower_shadow, 0)
	set_cell(0, Vector2i(7, randRangeTop + 7), 0, pipe_lower_cap, 0)
	
	for i in (15):
		set_cell(0, Vector2i(7, randRangeTop + 9 + i), 0, pipe_middle, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	spawn_pipes("green")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position.x -= 60 * delta

func _on_score_area_body_entered(body):
	if body.name == "Bird":
		scored.emit()
