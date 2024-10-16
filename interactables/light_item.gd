extends Grabbable
class_name LightItem

func pick_up(picked_up_by):
	super(picked_up_by)
	set_collision_layer_value(1, false if picked_up_by else true)
