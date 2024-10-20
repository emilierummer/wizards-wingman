extends Area2D

signal crow_went_through_portal

@export var start_showing: bool = true
var start_scale: Vector2

func _ready():
	start_scale = scale
	if not start_showing: scale = Vector2(0, 0)

func _on_body_entered_portal(body):
	if not body is CharacterBody2D: return
	crow_went_through_portal.emit()

func tween_show(delay = null):
	if delay: await get_tree().create_timer(delay).timeout
	create_tween().tween_property(self, "scale", start_scale, 0.25)

func tween_hide(delay = null):
	if delay: await get_tree().create_timer(delay).timeout
	create_tween().tween_property(self, "scale", Vector2(0, 0), 0.5)
