extends Node2D

@onready var Crow = $Crow
@onready var Camera = $Camera

func _process(_delta):
	Camera.offset.y = clampi(round(Crow.global_position.y), -350, 180)
