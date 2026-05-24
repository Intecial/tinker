extends Control
class_name GadgetGearSlot

@export var gadget_texture: TextureRect
var current_gear: GearResource
var gear_requirement: GearResource

func set_gear(gear_resource: GearResource) -> void:
	gadget_texture.texture = gear_resource.icon
	gadget_texture.modulate = gear_resource.color
	current_gear = gear_resource
	
func set_gear_requirement(gear_resource: GearResource) -> void:
	self.gear_requirement = gear_resource
#	gadget_texture.texture = gear_resource.icon
#	gadget_texture.modulate = gear_resource.color

func clear_slot() -> void:
	current_gear = null
	gadget_texture.texture = null
	gadget_texture.modulate = Color.WHITE
