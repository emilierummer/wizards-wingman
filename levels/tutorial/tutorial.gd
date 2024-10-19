extends "res://levels/tower/tower.gd"

signal level_completed

@onready var MoveLabel = $Tutorial/MoveLabel
@onready var GrabBeakLabel = $Tutorial/GrabBeakLabel
@onready var GrabClawsLabel = $Tutorial/GrabClawsLabel

@onready var BringLampSpeech = $Tutorial/BringLampSpeech
@onready var ShelfSpeech = $Tutorial/ShelfSpeech
@onready var GetRingSpeech = $Tutorial/GetRingSpeech
@onready var GetGoldSpeech = $Tutorial/GetGoldSpeech

var ring_in_potion = false


## 1. Pick up lamp
func _ready():
	MoveLabel.visible = true
	BringLampSpeech.visible = true

func _on_left_perch(body):
	if not body is CharacterBody2D: return
	MoveLabel.visible = false
	GrabClawsLabel.visible = true

func _on_lamp_picked_up():
	GrabClawsLabel.visible = false
	BringLampSpeech.visible = false
	ShelfSpeech.visible = true


## 2. Put lamp on bookshelf
func _on_lamp_put_on_bookshelf(body):
	if not body is HeavyItem: return
	GrabBeakLabel.visible = true
	ShelfSpeech.visible = false
	GetRingSpeech.visible = true


## 3. Pick up ring
func _on_ring_picked_up():
	GrabBeakLabel.visible = false


## 4. Put ring in cauldron
func _on_ring_put_in_cauldron(body):
	if body.name != "Ring": return
	body.queue_free()
	ring_in_potion = true
	GetRingSpeech.visible = false
	GetGoldSpeech.visible = true


## 5. Go through portal
func _on_go_through_portal(body):
	if not body is CharacterBody2D: return
	if ring_in_potion:
		level_completed.emit()
