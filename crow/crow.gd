extends CharacterBody2D

## Constants
static var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const GROUND_SPEED = 500
const FLIGHT_SPEED = 1000


## Onready Variables
@onready var Pivot = $Pivot
@onready var BodyCollider = $BodyCollider


## Complex Variables
var flipped: bool :
	set(value):
		flipped = value
		var flip_dir = -1 if value else 1
		if Pivot.scale.x != flip_dir:
			BodyCollider.scale.x = flip_dir
			Pivot.scale.x = flip_dir


func _physics_process(delta): 
	var speed = GROUND_SPEED if is_on_floor() else FLIGHT_SPEED
	var direction = 0
	
	## Movement direction
	if Input.is_action_pressed("MoveLeft"): 
		direction = -1
		self.flipped = true
	if Input.is_action_pressed("MoveRight"): 
		direction = 1
		self.flipped = false
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
