extends Control
## TO RENAME: ToolTipManager
class_name ToolTipManager

@export var toolTipScene: PackedScene
var tooltip_instance: Control
var gear_resource: GearResource
var sfx_resource: StatusEffectResource
var gadget_resource: GadgetResource

var is_shop: bool = false
func _on_mouse_entered() -> void:
	if not gear_resource and not sfx_resource and not gadget_resource:
		return
	var tooltip : ToolTip = _create_tooltip()
	if not tooltip:
		return
	
	if gear_resource:
		tooltip.set_gear_info(gear_resource, is_shop)
	elif sfx_resource:
		tooltip.set_sfx_info(sfx_resource)
	elif gadget_resource:
		tooltip.set_gadget_info(gadget_resource)

func _create_tooltip() -> ToolTip:
	tooltip_instance = toolTipScene.instantiate()
	add_child(tooltip_instance)
	tooltip_instance.scale = Vector2.ONE / get_global_transform().get_scale()
	if tooltip_instance is ToolTip:
		tooltip_instance.move_to_front()
		return tooltip_instance as ToolTip
	return null

func _on_mouse_exited() -> void:
	if tooltip_instance:
		tooltip_instance.queue_free()
		tooltip_instance = null

func _process(_delta: float) -> void:
	if tooltip_instance:
		var mouse_pos :Vector2 = get_global_mouse_position()
		var screen_size :Vector2 = get_viewport().get_visible_rect().size
		var tooltip_size :Vector2 = tooltip_instance.size
		var offset :Vector2 = Vector2(10, 10)

		if mouse_pos.x + tooltip_size.x + offset.x > screen_size.x:
			offset.x = -tooltip_size.x - 10  # flip to left
		if mouse_pos.y + tooltip_size.y + offset.y > screen_size.y:
			offset.y = -tooltip_size.y - 10  # flip upward

		tooltip_instance.global_position = mouse_pos + offset
