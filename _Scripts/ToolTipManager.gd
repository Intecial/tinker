extends Control
## TO RENAME: ToolTipManager
class_name ToolTipManager

@export var toolTipScene: PackedScene
var tooltip_instance: Control
var gear_resource: GearResource
var sfx_resource: StatusEffectResource
var is_shop: bool = false


func _on_mouse_entered() -> void:
	if gear_resource:
		tooltip_instance = toolTipScene.instantiate()
		self.add_child(tooltip_instance)  # add to root so it's on top
		if tooltip_instance is ToolTip:
			tooltip_instance.move_to_front()
			var toolTip: ToolTip = tooltip_instance as ToolTip
			toolTip.set_gear_info(gear_resource, is_shop)
	
	if sfx_resource:
		tooltip_instance = toolTipScene.instantiate()
		self.add_child(tooltip_instance)  # add to root so it's on top
		if tooltip_instance is ToolTip:
			tooltip_instance.move_to_front()
			var toolTip: ToolTip = tooltip_instance as ToolTip
			toolTip.set_sfx_info(sfx_resource)
		
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
