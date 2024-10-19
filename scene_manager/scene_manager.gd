extends Node2D

static var PackedTutorialScene = preload("res://levels/tutorial/tutorial.tscn")
static var PackedHouseScene = preload("res://levels/house/house.tscn")
static var PackedMarketScene = preload("res://levels/market/market.tscn")
static var PackedCastleScene = preload("res://levels/castle/castle.tscn")

@onready var TutorialScene = PackedTutorialScene.instantiate()
@onready var HouseScene = PackedHouseScene.instantiate()
@onready var MarketScene = PackedMarketScene.instantiate()
@onready var CastleScene = PackedCastleScene.instantiate()

func _ready():
	## Connect Signals
	TutorialScene.connect("level_completed", _on_tutorial_completed)
	
	## Spawn Tutorial
	call_deferred("add_child", TutorialScene)


func _on_tutorial_completed():
	call_deferred("remove_child", TutorialScene)
	call_deferred("add_child", HouseScene)
