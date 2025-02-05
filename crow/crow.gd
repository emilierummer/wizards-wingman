extends CharacterBody2D

## Constants
static var GRAVITY = ProjectSettings.get_setting("physics/2d/default_gravity") * 0.75
const GROUND_SPEED = 200
const FLIGHT_SPEED = 300

## Onready Variables
@onready var Pivot = $Pivot
@onready var BodyCollider = $BodyCollider
@onready var BodyAnimator = $BodyAnimations

@onready var ClawArea = $Pivot/ClawArea
@onready var BeakArea = $Pivot/BeakArea
@onready var BeakFloorArea = $Pivot/BeakFloorArea

@onready var HeldItemCollider = $HeldItemCollisionShape
@onready var initial_held_item_position = HeldItemCollider.position

## Other Variables
@export var disabled: bool = false
var flipped: bool :
	set(value):
		flipped = value
		var flip_dir = -1 if value else 1
		if Pivot.scale.x != flip_dir:
			BodyCollider.scale.x = flip_dir
			Pivot.scale.x = flip_dir
			HeldItemCollider.scale.x = flip_dir / self.scale.x
			if (HeldItemCollider.position.x < 0) != (flip_dir < 0): HeldItemCollider.position.x *= -1

var claw_object: Node2D
var beak_object: Node2D
var beak_floor_object: Node2D

var held_claws: HeavyItem :
	set(item):
		if item: 
			item.pick_up(self.ClawArea)
			HeldItemCollider.polygon = item.Collider.polygon
			HeldItemCollider.position.y = item.Collider.position.y / self.scale.y + initial_held_item_position.y
			HeldItemCollider.scale = Vector2(1, 1) / self.scale
		else: 
			held_claws.drop()
			HeldItemCollider.polygon = PackedVector2Array()
		held_claws = item
var held_beak: LightItem : 
	set(item):
		if item: item.pick_up(self.BeakArea)
		else: held_beak.drop()
		held_beak = item


func _physics_process(delta):
	if disabled: return
	############### MOVEMENT ###############
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
		BodyAnimator.play("flap_wings")
	
	## Gravity
	velocity.y += GRAVITY * delta # apply gravity
	
	## Move
	move_and_slide()
	
	################ ACTIONS ###############
	if Input.is_action_just_pressed("Beak"):
		if held_beak:
			held_beak = null
		elif beak_object:
			held_beak = beak_object
		elif beak_floor_object:
			held_beak = beak_floor_object
	if Input.is_action_just_pressed("Claws"):
		if held_claws:
			held_claws = null
		elif claw_object:
			held_claws = claw_object
	
	############## ANIMATIONS ##############
	if is_on_floor():
		if BodyAnimator.current_animation == "flap_wings":
			BodyAnimator.stop()
			BodyAnimator.queue("RESET")
			BodyAnimator.queue("idle")



## Object Handling
func _on_claw_area_entered(body):
	if body is HeavyItem:
		claw_object = body


func _on_claw_area_exited(body):
	if body == claw_object:
		claw_object = null


func _on_beak_area_entered(body):
	if body is LightItem:
		beak_object = body


func _on_beak_area_exited(body):
	if body == beak_object:
		beak_object = null


func _on_beak_floor_area_entered(body):
	if body is LightItem: 
		beak_floor_object = body


func _on_beak_floor_area_exited(body):
	if body == beak_floor_object:
		beak_floor_object = null
