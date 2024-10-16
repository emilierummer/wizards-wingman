extends CharacterBody2D

static var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const GROUND_SPEED = 500
const FLIGHT_SPEED = 1000

func _physics_process(delta): 
	var speed = GROUND_SPEED if is_on_floor() else FLIGHT_SPEED
	var direction = 0
	
	## Movement direction
	if Input.is_action_pressed("MoveLeft"): direction = -1
	if Input.is_action_pressed("MoveRight"): direction = 1
	velocity.x = direction * speed
	
	## Fly
	if Input.is_action_pressed("MoveUp"):
		velocity.y = -speed
	
	## Gravity
	velocity.y += GRAVITY * delta # apply gravity
	
	## Move
	move_and_slide()

func _process(delta):
	## Actions
	if Input.is_action_just_pressed("Beak"):
		print("beak")
	if Input.is_action_just_pressed("Claws"):
		print("claws")
