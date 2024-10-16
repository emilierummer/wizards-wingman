extends CharacterBody2D

## Constants
static var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity")
const GROUND_SPEED = 500
const FLIGHT_SPEED = 1000
@onready var INITIAL_SCALE = $BodyCollider.scale.x


## Onready Variables
@onready var Sprite = $Sprite
@onready var BodySprite = $Sprite/BodySprite
@onready var EyeSprite = $Sprite/BodySprite/EyeSprite
@onready var WingSprite = $Sprite/WingSprite
@onready var BodyCollider = $BodyCollider


## Complex Variables
var flipped: bool :
	set(value):
		flipped = value
		Sprite.flip_h = value
		BodySprite.flip_h = value
		EyeSprite.flip_h = value
		WingSprite.flip_h = value
		BodyCollider.scale.x = -INITIAL_SCALE if value else INITIAL_SCALE



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
