extends Node

#var tile: Tile = preload()
var PLAYER: Actor
var GEAR_ARRAY: GearArray
var GEAR_INVENTORY: GearInventory
var ROUND_MANAGER: RoundManager
var ENEMY_MANAGER: EnemyManager
var SHOP_ARRAY: ShopArray
var PANEL_MANAGER: PanelManager
var ROUTE_GENERATOR: RouteGenerator

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
		"Investment": load("uid://bemrmlkhxiid3"),
		"GainStrength": load("uid://bbmgqusjnl1q"),
		"Overload": load("uid://cwnc3tvdcr2lt"),
		"ApplyLubricant": load("uid://cy6ovmh6a21p8"),
		"Spark": load("uid://tg2ype0wbiad"),
		"Raise": load("uid://b224avev1pwlv")
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
	preload("uid://b8sssqoufa74d"), # Clockwork
	preload("uid://bx6gyv0i5xcu4"), # The Gambler
	preload("uid://dq0bsy8yi2bmx") # Sentient Wrench
	]
# Constant.gd
var CAMERA: Camera2D
var CANVAS_LAYER: CanvasLayer

func screenshake(duration: float = 0.3, strength: float = 10.0) -> void:
	_shake_node(CAMERA, "offset", duration, strength)
	_shake_node(CANVAS_LAYER, "offset", duration, strength)

func _shake_node(node: Node, property: String, duration: float, strength: float) -> void:
	if not node:
		return
	
	var tween :Tween = node.create_tween()
	var original :Vector2 = node.get(property)
	
	for i :int in range(10):
		tween.tween_property(node, property, Vector2(
			randf_range(-strength, strength),
			randf_range(-strength, strength)
		), duration / 10.0)
	
	tween.tween_property(node, property, original, 0.1)
