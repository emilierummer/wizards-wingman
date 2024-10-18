extends Node2D

const ROOM_TRANSITION_SPEED = 0.5

@onready var OuterRoom = $HouseOuter
@onready var InnerRoom = $HouseInner
@onready var Necklace = $Necklace
@onready var Camera = $Camera

var visible_room : Node :
	set(room):
		visible_room = room
		await get_tree().create_timer(ROOM_TRANSITION_SPEED).timeout
		visible_room.visible = true
		visible_room.modulate = Color.WHITE

var door_open = true
var holding_necklace = false


func _on_outer_room_area_entered(body):
	if body is CharacterBody2D:
		tween_rooms(OuterRoom, InnerRoom, 320)
	elif body == Necklace and not holding_necklace:
		Necklace.reparent(OuterRoom)


func _on_inner_room_area_entered(body):
	if body is CharacterBody2D and door_open:
		tween_rooms(InnerRoom, OuterRoom, 500)
	elif body == Necklace and not holding_necklace:
		Necklace.reparent(InnerRoom)


func tween_rooms(show:Node, hide:Node, cameraOffset:float):
	var tween = get_tree().create_tween()
	visible_room = show
	
	tween.tween_property(Camera, "offset:x", cameraOffset, ROOM_TRANSITION_SPEED)
	tween.parallel().tween_property(hide, "modulate", Color.TRANSPARENT, ROOM_TRANSITION_SPEED)
	tween.parallel().tween_property(show, "visible", true, 0)
	
	tween.tween_property(hide, "visible", false, 0)
	tween.parallel().tween_property(hide, "modulate", Color.WHITE, 0)


func _on_necklace_picked_up():
	holding_necklace = true
	Necklace.reparent(self)
	print("reparent to self")


func _on_necklace_dropped():
	holding_necklace = false
