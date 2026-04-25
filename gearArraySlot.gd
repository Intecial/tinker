extends PanelContainer
class_name GearArraySlot

var spinContent : bool = false
@export var shakeScreen: bool = false
@export var activateExplosion: bool = false
@export var isClockwise: bool = false
@export var explosionOnGear: ExplosionOnGear
@export var isShop: bool = false

var gear: GearResource = null

var isDisabled : bool = false

signal onHovered(slot: GearArraySlot)
signal onExit

@onready var iconRect: TextureRect = $TextureRect

func _ready() -> void:
	await get_tree().process_frame
	initLoc()

func initLoc() -> void:
	await get_tree().process_frame
	iconRect.pivot_offset = iconRect.size / 2
	explosionOnGear.position = iconRect.size / 2
	
func _process(delta: float) -> void:
	if spinContent:
		if isClockwise:
			iconRect.rotation += 2.0 * delta
		else:
			iconRect.rotation -= 2.0 * delta

func _get_drag_data(at_position: Vector2) -> Variant:
	if isDisabled:
		return
	if gear == null:
		return null
	
	var preview := TextureRect.new()
	preview.texture = gear.icon
	preview.modulate = gear.color
	preview.size = Vector2(80, 80)
	preview.position = -preview.size / 2  # center on mouse
	
	var control := Control.new()
	control.add_child(preview)
	set_drag_preview(control)
		
	return self

func _can_drop_data(at_position: Vector2, data: Variant) -> bool:
	return data is GearArraySlot 

func _drop_data(at_position: Vector2, data: Variant) -> void:
	if isDisabled:
		return
	if !(data is GearArraySlot):
			return
	var fromSlot : GearArraySlot = data as GearArraySlot
	if fromSlot.isShop && self.isShop:
		return
	if fromSlot.isShop:
		if not Constant.PLAYER.useKnowledge(fromSlot.gear.buyValue):
			return
	swapGear(fromSlot)

func swapGear(other: GearArraySlot) -> void:
	var temp := gear
	setGear(other.gear)
	other.setGear(temp)

func setGear(newGear: GearResource) -> void:
	gear = newGear
	if gear != null:
		$TextureRect.texture = gear.icon
		$TextureRect.modulate = gear.color
		
		if shakeScreen:
			screenShake()
		if activateExplosion:
			explode()
		if isShop:
			explode()
			await get_tree().create_timer(0.5).timeout
	else:
		$TextureRect.texture = null
		$TextureRect.modulate = Color.WHITE

func screenShake() -> void:
	var root := get_tree().current_scene
	print("shaking: ", root.name, " at ", root.position)
	var tween := root.create_tween()
	var original := Vector2(root.position)
	
	tween.tween_property(root, "position", original + Vector2(10, 0), 0.05)
	tween.tween_property(root, "position", original + Vector2(-10, 0), 0.05)
	tween.tween_property(root, "position", original + Vector2(5, 0), 0.05)
	tween.tween_property(root, "position", original, 0.05)

func disableSlot():
	isDisabled = true
	
func enableSlot():
	isDisabled = false

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
	