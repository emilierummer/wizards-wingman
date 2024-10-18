extends Node2D

@onready var Crow = $Crow
@onready var Camera = $Camera

func _process(_delta):
	Camera.offset.y = clamp(Crow.global_position.y, -350, 180)
