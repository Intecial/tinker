extends Node

#var tile: Tile = preload()
var PLAYER: Actor
var GEAR_ARRAY: GearArray
var GEAR_INVENTORY: GearInventory
var ROUND_MANAGER: RoundManager
var ENEMY_MANAGER: EnemyManager
var SHOP_ARRAY: ShopArray
var PANEL_MANAGER: PanelManager

var GEAR_DICT: Dictionary[String, GearResource] = {}

func _ready() -> void:
	GEAR_DICT = {
		"Strike": load("uid://dt1eu36i6lpyk"),
		"Defend": load("uid://nonsbjkfwx4f"),
		"Heal": load("uid://dojod3gfsu3ma"),
		"Berserk": load("uid://cfafkvsw2xgup"),
		"ShieldBash": load("uid://c3vsrhnhp3nip"),
		"StrongGuard": load("uid://bxs7468dpdne"),
		"FullDrive": load("uid://bwus5g2cx50e0"),
		"Income": load("uid://dvg1nvkuobkea"),
		"Sentry": load("uid://yyk7c4xoua35"),
		"PiggyBank": load("uid://bmoq1rkw8fkax")
	}
var BASIC_GEAR_DICT: Dictionary[String, GearResource] = {
	"Strike": preload("uid://dt1eu36i6lpyk"),
	"Defend": preload("uid://nonsbjkfwx4f"),
	"Heal": preload("uid://dojod3gfsu3ma"),
}
var FX_LAYER: FXLayer
var TEXT_CONTAINER: TextContainer


var animSpeed: float = 0.8

var ENEMY_RESOURCES: Array[EnemyResource] = [
	preload("uid://pru0vy3i64th"), 
	preload("uid://ck14shu7bawrs"),
	preload("uid://8bxpxc5ux5iv")
	]
