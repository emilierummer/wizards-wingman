extends Node2D

signal level_completed

@onready var Crow = $Crow
@onready var Camera = $Camera

func _process(_delta):
	Camera.offset.y = clampi(round(Crow.global_position.y), -350, 180)


func _on_cauldron_area_entered(body):
	if body.name == "Ring":
		level_completed.emit()
