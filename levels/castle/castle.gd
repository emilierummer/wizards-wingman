extends Node2D

signal level_completed

func _ready():
	$EntryPortal.tween_hide(0.25)


func _on_chalice_picked_up():
	$ExitPortal.tween_show()


func _on_crow_went_through_exit_portal():
	level_completed.emit()
