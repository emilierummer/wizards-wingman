extends RigidBody2D
class_name Grabbable

static var GRAVITY = ProjectSettings.get_setting("physics/3d/default_gravity")

var velocity = Vector2(0, 0)

var held_by: Node2D : 
	set(node):
		held_by = node
		freeze = true if node else false
		set_collision_layer_value(1, false if node else true)


func pick_up(picked_up_by):
	held_by = picked_up_by
	rotation = 0


func drop():
	held_by = null


func _physics_process(_delta):
	if held_by:
		self.global_transform.origin = held_by.global_position
