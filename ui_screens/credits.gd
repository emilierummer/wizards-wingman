extends PanelContainer


@onready var Objects = [ $Chalice, $Ring, $Necklace, $Coin ]
var reset_velocity = {}

func _physics_process(delta):
	for object in Objects:
		if object.global_position.y >= 450:
			object.global_position.y = -100
			object.linear_velocity = Vector2(0, 0)
			object.rotation = randi_range(-45, 45)
			if randi_range(0, 1):
				object.global_position.x = randi_range(30, 160) # left
			else:
				object.global_position.x = randi_range(500, 600) # right
