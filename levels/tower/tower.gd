extends Node2D

signal left_tower

@onready var Crow = $Crow
@onready var Camera = $Camera

@export var spawn_holding: Grabbable = null
@export var last_level: bool = false

## Align camera with crow
func _process(_delta):
	Camera.offset.y = clampi(round(Crow.global_position.y), -350, 180)


## Show and hide portals
func _ready():
	## Set up nodes
	if spawn_holding is HeavyItem:
		add_child(spawn_holding)
		Crow.held_claws = spawn_holding
	elif spawn_holding is LightItem:
		add_child(spawn_holding)
		Crow.held_beak = spawn_holding
	
	## Hide entry portal
	$EntryPortal.tween_hide(0.25)


func _on_body_entered_cauldron(body):
	if not body is Grabbable: return
	body.queue_free()
	if last_level: $CompleteSpeech.visible = true
	$ExitPortal.tween_show()


func _on_crow_went_through_exit_portal():
	left_tower.emit()
