# 2D Character Controller
extends KinematicBody2D

# This variable controls the gravity of the game
onready var GRAVITY = -9.8

#String that represents the action of moving to the right
export(bool) var Animated_Sprite = false
#String that represents the action of moving to the right
export(String) var Right_Action = "ui_right"
#String that represents the action of moving to the left
export(String) var Left_Action = "ui_left"
#String that represents the jump action
export(String) var Jump_Action = "ui_up"
#String that represents the moving animation
export(String) var Anim_Walk = "Walk"
#String that represents the stop animation
export(String) var Anim_Idle = "Idle"
#String that represents the jumping animation
export(String) var Anim_Jump = "Jump"
#String that represents the damage animation
export(String) var Anim_Hurt = "Hurt"

#Weight of the character, influence on the speed of the fall.
export(int) var Weight =  40
# This variable controls the speed of the player.
export(int) var Velocity =  500

func _ready():
	if Animated_Sprite == true:
		get_child(0).visible = false
	else:
		get_child(2).visible = false
	set_physics_process(true)

# Function responsible for applying the gravity of the character.
func _gravity(delta):
	
	# This section serves to regulate the salvo, so if the gravity is greater than the initial one, it gradually reduces.
	if GRAVITY > -9.8:
		GRAVITY -= Weight * delta
	else:
		GRAVITY == -9.8
	
	# Apply gravity to the movement, here was chosen the use of Move_And_Slide so that it is possible to update the function "on_floor".
	move_and_slide(Vector2(0, GRAVITY * -3000 * delta), Vector2(0, -1), 25.0)

# Function responsible for receiving inputs from the player.
func _controls(delta):
	if Input.is_action_just_pressed(Jump_Action) and is_on_floor():
		GRAVITY = 18
	
	#Check that the action has been performed
	if Input.is_action_pressed(Right_Action):
		#AApply the movement to the character
		move_and_collide(Vector2(Velocity *delta,0))
		
		
		if Animated_Sprite == false:
			#plays the walking animation on the animation controller
			if get_child(1).current_animation != Anim_Walk:
				get_child(1).play(Anim_Walk)
				#Turn the sprite right
			if get_child(0).scale.x != 1:
				get_child(0).scale.x = 1
		else:
			#Turn the sprite right
			get_child(2).flip_h = false
			#plays the walking animation on the animation sprite node
			if get_child(2).animation != Anim_Walk:
				get_child(2).play(Anim_Walk)
	
	#Checks of the action was performed
	if Input.is_action_pressed(Left_Action):
		#Apply the movement to the character
		move_and_collide(Vector2(Velocity * -1 *delta,0))
		
		if Animated_Sprite == false:
		#plays the walking animation on the animation controller
			if get_child(1).current_animation != Anim_Walk:
				get_child(1).play(Anim_Walk)
			#Turn the sprite left
			if get_child(0).scale.x != -1:
				get_child(0).scale.x = -1
		else:
				#Turn the sprite left
				get_child(2).flip_h = true
				#plays the walking animation on the animation sprite node
				if get_child(2).animation != Anim_Walk:
					get_child(2).play(Anim_Walk)
	
	if is_on_floor():
		#Checks if no action is being performed
		if !Input.is_action_pressed(Right_Action) and !Input.is_action_pressed(Left_Action) and is_on_floor():
			#plays the idle animation on the animation controller
			if Animated_Sprite == false:
				if get_child(1).current_animation != Anim_Idle:
					get_child(1).play(Anim_Idle)
			#plays the jump animation on the animation sprite node
			else:
					if get_child(2).animation != Anim_Idle:
						get_child(2).play(Anim_Idle)
	else:
		#plays the jump animation on the animation controller
		if Animated_Sprite == false:
			if get_child(1).current_animation != Anim_Jump:
				get_child(1).play(Anim_Jump)
		#plays the jump animation on the animation sprite node
		else:
			if get_child(2).animation != Anim_Jump:
				get_child(2).play(Anim_Jump)

# Controls the execution loop.
func _physics_process(delta):
	_gravity(delta)
	_controls(delta)