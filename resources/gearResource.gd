extends Resource
class_name GearResource

enum GearType { DAMAGE, SHIELD, HEAL, MONEY }

@export var gearName: String = ""
@export var gearType: GearType = GearType.DAMAGE
@export var icon: Texture2D = preload("uid://cny81hpwe5fq4")
@export var actions: Array[ActionResource]
@export var color: Color
@export var isConsumable: bool = false
var isMerged: bool = false

@export_category("Shop")
@export var buyValue: int = 0
@export var sellValue: int = 0

@export_multiline var description: String = ""

func _init() -> void:
	for action: ActionResource in actions:
		print(action)
		action.gear = self

func evaluate(target: Actor) -> void:
	_init()
	for action: ActionResource in actions:
		action.execute(target)
	await flash(Constant.FX_LAYER)

func sell_gear() -> void:
	for action: ActionResource in actions:
		action.on_gear_sold()
	
func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = color
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, 0.8)
	tween.tween_callback(rect.queue_free) # clean up after
	
	await tween.finished
