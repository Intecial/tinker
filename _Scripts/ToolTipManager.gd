extends Control
## TO RENAME: ToolTipManager
class_name ToolTipManager

@export var toolTipScene: PackedScene
var tooltip_instance: Control
var gear_resource: GearResource
var sfx_resource: StatusEffectResource


func _on_mouse_entered() -> void:
	if gear_resource:
		tooltip_instance = toolTipScene.instantiate()
		self.add_child(tooltip_instance)  # add to root so it's on top
		if tooltip_instance is ToolTip:
			tooltip_instance.move_to_front()
			var toolTip: ToolTip = tooltip_instance as ToolTip
			toolTip.set_gear_info(gear_resource)
	
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
		tooltip_instance.global_position = get_global_mouse_position() + Vector2(10, 10)
