extends PanelContainer
class_name GearSellSlot


var spinContent : bool = false
@export var shakeScreen: bool = false
@export var activateExplosion: bool = false
@export var isClockwise: bool = false
@export var explosionOnGear: ExplosionOnGear


var gear: GearResource = null

var isDisabled : bool = false

@onready var iconRect: TextureRect = $MarginContainer/TextureRect
@onready var sellAmount: RichTextLabel = $MarginContainer/Amount

func _ready() -> void:
	await get_tree().process_frame
	initLocal()

func initLocal() -> void:
	sellAmount.pivot_offset = sellAmount.size / 2
	explosionOnGear.position = sellAmount.size / 2
	
func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	var fromSlot : GearArraySlot = data as GearArraySlot
	
	sellAmount.text = str(fromSlot.gear.sellValue)
	return data is GearArraySlot 

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if isDisabled:
		return
	var fromSlot : GearArraySlot = data as GearArraySlot
	if fromSlot.isShop:
		return
	if fromSlot.gear == null:
		return
	
	screenShake()
	explosionOnGear.burst(fromSlot.gear.color)
	Constant.PLAYER.addKnowledge(fromSlot.gear.sellValue) # or use gear.sellValue
	fromSlot.setGear(null) # remove from original slot

func screenShake() -> void:
	var root : Control = get_tree().current_scene
	var tween : Tween = root.create_tween()
	var original : Vector2 = Vector2(root.position)
	
	tween.tween_property(root, "position", original + Vector2(10, 0), 0.05)
	tween.tween_property(root, "position", original + Vector2(-10, 0), 0.05)
	tween.tween_property(root, "position", original + Vector2(5, 0), 0.05)
	tween.tween_property(root, "position", original, 0.05)


#func explode() -> void:
#	explosionOnGear.burst(gear.color)


func _on_margin_container_mouse_exited() -> void:
	sellAmount.text = "Sell"
