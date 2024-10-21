extends Node

static var PackedTowerScene = preload("res://levels/tower/tower.tscn")

@onready var TutorialScene = preload("res://levels/tutorial/tutorial.tscn").instantiate()
@onready var MarketScene = preload("res://levels/market/market.tscn").instantiate()
@onready var CastleScene = preload("res://levels/castle/castle.tscn").instantiate()
@onready var TitleScreen = preload("res://ui_screens/title.tscn").instantiate()
@onready var CreditsScreen = preload("res://ui_screens/credits.tscn").instantiate()

@onready var TowerScene = PackedTowerScene.instantiate()

var active_level = 0

func _ready():
	## Connect Signals
	TutorialScene.connect("level_completed", _on_tutorial_completed)
	MarketScene.connect("level_completed", _on_market_completed)
	CastleScene.connect("level_completed", _on_castle_completed)
	TitleScreen.connect("play_pressed", _on_title_play_pressed)
	
	TowerScene.connect("left_tower", _on_leave_tower)
	
	## Spawn Tutorial
	call_deferred("add_child", TitleScreen)


func _on_title_play_pressed():
	call_deferred("remove_child", TitleScreen)
	call_deferred("add_child", TutorialScene)


func _on_tutorial_completed():
	call_deferred("remove_child", TutorialScene)
	call_deferred("add_child", MarketScene)
	active_level = 1


func _on_market_completed():
	call_deferred("remove_child", MarketScene)
	TowerScene.spawn_holding = preload("res://interactables/gold_objects/coin/coin.tscn").instantiate()
	call_deferred("add_child", TowerScene)
	active_level = 2


func _on_castle_completed():
	call_deferred("remove_child", CastleScene)
	TowerScene.spawn_holding = preload("res://interactables/gold_objects/chalice/chalice.tscn").instantiate()
	TowerScene.last_level = true
	call_deferred("add_child", TowerScene)
	active_level = null


func _on_leave_tower():
	call_deferred("remove_child", TowerScene)
	TowerScene = PackedTowerScene.instantiate()
	TowerScene.connect("left_tower", _on_leave_tower)
	match active_level:
		1: call_deferred("add_child", MarketScene)
		2: call_deferred("add_child", CastleScene)
		null: call_deferred("add_child", CreditsScreen)
