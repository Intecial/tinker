extends Control
class_name GadgetPedestal

@export var gadget_resource: GadgetResource
@export var gadget_gear_slot: PackedScene
@export var gadget_gear_slot_container: Control
@export var active_icon : TextureRect
@export var tooltipManager: ToolTipManager

var slots: Array[GadgetGearSlot] = []
var is_active: bool = false
var is_ready: bool = false
var is_hovered: bool = false

func _ready() -> void:
	init_pedestal(gadget_resource)
	update_active_icon()
	tooltipManager.gadget_resource = gadget_resource

func update_active_icon() -> void:
	if is_ready:
		if is_active:
			active_icon.modulate = Color.GREEN
		else:
			active_icon.modulate = Color.RED
	else:
		active_icon.modulate = Color.RED

func init_pedestal(init_gadget_resource: GadgetResource) -> void:
	self.gadget_resource = init_gadget_resource
	for gear: GearResource in init_gadget_resource.gear_requirements:
		var gear_slot: GadgetGearSlot = gadget_gear_slot.instantiate()
		gear_slot.set_gear_requirement(gear)
		gadget_gear_slot_container.add_child(gear_slot)
		slots.append(gear_slot)

func try_populate_gadget(gear_resource: GearResource) -> bool:
	for slot: GadgetGearSlot in slots:
		if slot.gear_requirement.gearType == gear_resource.gearType:
			slot.set_gear(gear_resource)
			check_is_ready()
			return true
	return false

func check_is_ready() -> void:
	for slot: GadgetGearSlot in slots:
		if slot.current_gear.gearType != slot.gear_requirement.gearType:
			is_ready = false
			return
	is_ready = true
	update_active_icon()

func resolve() -> void:
	for action: ActionResource in gadget_resource.actions:
		await action.execute(Constant.PLAYER)
	for slot: GadgetGearSlot in slots:
		slot.clear_slot()
	is_ready = false
	is_active = false
	update_active_icon()
	await get_tree().process_frame

func _on_mouse_exited() -> void:
	is_hovered = false

func _on_mouse_entered() -> void:
	is_hovered = true
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("mouse_left") and is_hovered:
		if is_ready:
			is_active = !is_active
		else:
			is_active = false
		update_active_icon()
