extends PanelContainer
class_name GearDisplayContainer

@export var gear_resource: GearResource
@export var texture_rect: TextureRect
@export var tooltip_manager: ToolTipManager

func init_container(_gear_resource: GearResource) -> void:
	self.texture_rect.texture = _gear_resource.icon
	self.gear_resource = _gear_resource
	texture_rect.modulate = _gear_resource.color
	tooltip_manager.gear_resource = _gear_resource
