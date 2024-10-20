extends Node2D

@onready var RightShopkeeper = $RightShopkeeper
@onready var Right_Timer = $RightShopkeeper/Timer
@onready var Right_AnimationPlayer = $RightShopkeeper/AnimationPlayer
var next_animation_right_shopkeeper = "walk_right"

@onready var LeftShopkeeper = $LeftShopkeeper
@onready var Left_Timer = $LeftShopkeeper/Timer
@onready var Left_AnimationPlayer = $LeftShopkeeper/AnimationPlayer
var next_animation_left_shopkeeper = "look_straight"

@onready var Customer = $Customer
@onready var Customer_Timer = $Customer/Timer
@onready var Customer_AnimationPlayer = $Customer/AnimationPlayer
var next_animation_customer = "walk_right"

@onready var Crow = $Crow
@onready var Crow_AnimationPlayer = $Crow/BodyAnimations

func _ready():
	Right_Timer.start(randf_range(1, 5))
	Customer_Timer.start(randf_range(1, 5))
	Left_Timer.start(randf_range(1, 5))



func _on_right_shopkeeper_timer_timeout():
	Right_AnimationPlayer.play(next_animation_right_shopkeeper)

func _on_right_shopkeeper_animation_finished(anim_name):
	next_animation_right_shopkeeper = "walk_right" if anim_name == "walk_left" else "walk_left"
	Right_Timer.start(randf_range(1, 5))



func _on_customer_timer_timeout():
	Customer_AnimationPlayer.play(next_animation_customer)

func _on_customer_animation_finished(anim_name):
	if anim_name == "walk_left":
		next_animation_customer = "walk_right"
		Customer_Timer.start(randf_range(3, 7))
	else: 
		next_animation_customer = "walk_left"
		Customer_Timer.start(randf_range(1, 5))



func _on_left_shopkeeper_timer_timeout():
	Left_AnimationPlayer.play(next_animation_left_shopkeeper)

func _on_left_shopkeeper_animation_finished(anim_name):
	if anim_name == "look_straight":
		if randi_range(0, 1):
			next_animation_left_shopkeeper = "look_left"
		else:
			next_animation_left_shopkeeper = "look_back"
		Left_Timer.start(randf_range(15, 30))
	else:
		next_animation_left_shopkeeper = "look_straight"
		Left_Timer.start(randf_range(2, 7))



func _on_sightline_body_entered(body):
	if body is CharacterBody2D: _on_crow_spotted()


func _on_crow_spotted():
	if not Crow.held_beak: return
	Crow.held_beak = null
	Crow.disabled = true
	var tween = create_tween()
	tween.tween_property(Crow, "global_position", Vector2(54, 94), 0.5)
	Crow_AnimationPlayer.call_deferred("stop")
	Crow_AnimationPlayer.call_deferred("queue", "RESET")
	Crow_AnimationPlayer.call_deferred("queue", "flap_wings")
	await tween.finished
	Crow.disabled = false
