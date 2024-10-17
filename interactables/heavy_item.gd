extends Grabbable
class_name HeavyItem

@onready var height = $Collider.shape.size.y
@onready var Collider = $Collider

func pick_up(picked_up_by):
	super(picked_up_by)
	rotation = 0
