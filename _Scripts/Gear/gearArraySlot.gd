extends PanelContainer
class_name GearArraySlot

var spinContent : bool = false
@export var shakeScreen: bool = false
@export var activateExplosion: bool = false
@export var isClockwise: bool = false
@export var explosionOnGear: ExplosionOnGear
@export var isShop: bool = false
@export var tooltip_manager: ToolTipManager
var gear: GearResource = null

var isDisabled : bool = false

signal onHovered(slot: GearArraySlot)
signal onExit

signal onGearSet(slot: GearArraySlot)
signal onGearRemoved(slot: GearArraySlot)

@onready var iconRect: TextureRect = $TextureRect
@onready var disabledRect: TextureRect = $MarginContainer/DisabledTexture
@onready var borderRect: TextureRect = $MarginContainer/MarginContainer/BorderRect
@onready var disabledColorRect: ColorRect = $ColorRect

func _ready() -> void:
	await get_tree().process_frame
	initLoc()

func initLoc() -> void:
	await get_tree().process_frame
	iconRect.pivot_offset = iconRect.size / 2
	explosionOnGear.position = iconRect.size / 2
	if isShop:
		tooltip_manager.is_shop = true
	
func _process(delta: float) -> void:
	if spinContent:
		if isClockwise:
			iconRect.rotation += 2.0 * delta
		else:
			iconRect.rotation -= 2.0 * delta

func _get_drag_data(_at_position: Vector2) -> Variant:
	if isDisabled:
		return
	if gear == null:
		return null
	
	var preview : TextureRect = TextureRect.new()
	preview.texture = gear.icon
	preview.modulate = gear.color
	preview.size = Vector2(80, 80)
	preview.position = -preview.size / 2  # center on mouse
	
	var control : Control = Control.new()
	control.add_child(preview)
	set_drag_preview(control)
		
	return self

func _can_drop_data(_at_position: Vector2, data: Variant) -> bool:
	return data is GearArraySlot 

func _drop_data(_at_position: Vector2, data: Variant) -> void:
	if isDisabled:
		return
	
	if !(data is GearArraySlot):
		return
	@warning_ignore("unsafe_cast")
	var fromSlot : GearArraySlot = data as GearArraySlot
	if fromSlot.isShop && self.isShop:
		return
	if fromSlot.isShop:
		if not Constant.PLAYER.useKnowledge(fromSlot.gear.buyValue):
			return
	swapGear(fromSlot)

func swapGear(other: GearArraySlot) -> void:
	var temp : GearResource = gear
	
	setGear(other.gear)
	
	other.setGear(temp)

func setGear(newGear: GearResource) -> void:
	gear = newGear
	if gear != null:
		iconRect.texture = gear.icon
		iconRect.modulate = gear.color
		
		if shakeScreen:
			screenShake()
		if activateExplosion:
			explode()
		if isShop:
			explode()
			await get_tree().create_timer(0.5).timeout
		onGearSet.emit(self)
	else:
		iconRect.texture = null
		iconRect.modulate = Color.WHITE
		onGearRemoved.emit(self)
	tooltip_manager.gear_resource = newGear

func screenShake() -> void:
	Constant.screenshake() 
#	var root : Control = get_tree().current_scene
#	
#	var tween : Tween = root.create_tween()
#	var original : Vector2 = Vector2(root.position)
#	
#	tween.tween_property(root, "position", original + Vector2(10, 0), 0.05)
#	tween.tween_property(root, "position", original + Vector2(-10, 0), 0.05)
#	tween.tween_property(root, "position", original + Vector2(5, 0), 0.05)
#	tween.tween_property(root, "position", original, 0.05)

func disableSlot() -> void:
	isDisabled = true
	disabledRect.visible = true
	disabledColorRect.visible = true
#	borderRect.visible = false
	
func enableSlot() -> void:
	isDisabled = false
	disabledRect.visible = false
	disabledColorRect.visible = false
#	borderRect.visible = true

func _mouse_entered() -> void:
	onHovered.emit(self)

func _mouse_exited() -> void:
	onExit.emit()
	
func explode() -> void:
	explosionOnGear.burst(gear.color)

func removeGear() -> void:
	if gear == null:
		return
	
	var icon : TextureRect = TextureRect.new()
	icon.texture = gear.icon
	icon.modulate = gear.color
	icon.size = iconRect.size
	icon.position = global_position
	get_tree().current_scene.add_child(icon)
	
	setGear(null)
	
	var tween: Tween = icon.create_tween()
	tween.tween_property(icon, "scale", Vector2(1.3, 1.3), 0.1)\
		.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	# fall down and fade out
	tween.tween_property(icon, "position", icon.position + Vector2(0, 300), 0.4)\
		.set_trans(Tween.TRANS_QUAD).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(icon, "modulate:a", 0.0, 0.4)
	
	await tween.finished
	icon.queue_free()
	



func _on_mouse_exited() -> void:
	print("Test")
	self._mouse_exited()

func _on_mouse_entered() -> void:
	self._mouse_entered()
