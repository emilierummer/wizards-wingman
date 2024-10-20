extends Node2D

static var PackedTutorialScene = preload("res://levels/tutorial/tutorial.tscn")
static var PackedHouseScene = preload("res://levels/house/house.tscn")
static var PackedMarketScene = preload("res://levels/market/market.tscn")
static var PackedCastleScene = preload("res://levels/castle/castle.tscn")
static var PackedTowerScene = preload("res://levels/tower/tower.tscn")

@onready var TutorialScene = PackedTutorialScene.instantiate()
@onready var HouseScene = PackedHouseScene.instantiate()
@onready var MarketScene = PackedMarketScene.instantiate()
@onready var CastleScene = PackedCastleScene.instantiate()
@onready var TowerScene = PackedTowerScene.instantiate()

var active_level = 0

func _ready():
	## Connect Signals
	TutorialScene.connect("level_completed", _on_tutorial_completed)
	HouseScene.connect("level_completed", _on_house_completed)
	MarketScene.connect("level_completed", _on_market_completed)
	CastleScene.connect("level_completed", _on_castle_completed)
	
	TowerScene.connect("left_tower", _on_leave_tower)
	
	## Spawn Tutorial
	call_deferred("add_child", TutorialScene)


func _on_tutorial_completed():
	call_deferred("remove_child", TutorialScene)
	# TODO: decide if house scene exists
	call_deferred("add_child", MarketScene)
	active_level = 2


func _on_house_completed():
	call_deferred("remove_child", HouseScene)
	TowerScene.spawn_holding = preload("res://interactables/gold_objects/necklace/necklace.tscn").instantiate()
	call_deferred("add_child", TowerScene)
	active_level = 2


func _on_market_completed():
	call_deferred("remove_child", MarketScene)
	TowerScene.spawn_holding = preload("res://interactables/gold_objects/coin/coin.tscn").instantiate()
	call_deferred("add_child", TowerScene)
	active_level = 3


func _on_castle_completed():
	call_deferred("remove_child", CastleScene)
	TowerScene.spawn_holding = preload("res://interactables/gold_objects/chalice/chalice.tscn").instantiate()
	call_deferred("add_child", TowerScene)
	active_level = null


func _on_leave_tower():
	call_deferred("remove_child", TowerScene)
	TowerScene = PackedTowerScene.instantiate()
	TowerScene.connect("left_tower", _on_leave_tower)
	match active_level:
		1: call_deferred("add_child", HouseScene)
		2: call_deferred("add_child", MarketScene)
		3: call_deferred("add_child", CastleScene)
		null: print_debug("Game completed!")
