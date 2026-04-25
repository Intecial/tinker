extends Node

#var tile: Tile = preload()
var PLAYER: Actor
var GEAR_ARRAY: GearArray
var GEAR_INVENTORY: GearInventory
var ROUND_MANAGER: RoundManager
var ENEMY_MANAGER: EnemyManager
var ENEMY_PANEL: EnemyPanel
var SHOP_PANEL: ShopPanel 
var SHOP_ARRAY: ShopArray
var GEAR_DICT : Dictionary[String, GearResource] = {
	"Strike": preload("uid://dt1eu36i6lpyk"),
	"Defend": preload("uid://nonsbjkfwx4f"),
	"Heal": preload("uid://dojod3gfsu3ma"),
	"Berserk": preload("uid://cfafkvsw2xgup"),
	"ShieldBash": preload("uid://c3vsrhnhp3nip"),
	"StrongGuard": preload("uid://bxs7468dpdne"),
	"FullDrive": preload("uid://bwus5g2cx50e0"),
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
	preload("uid://pru0vy3i64th")
	]
