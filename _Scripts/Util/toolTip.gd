extends PanelContainer
class_name ToolTip

@export var display_name: RichTextLabel
@export var icon :TextureRect
@export var label : RichTextLabel
@export var price: RichTextLabel
@export var permanent_panel: Control
func setText(txt: String) -> void:
	label.text = txt
	display_name.visible = false
	icon.visible = false
	
func set_gear_info(gear_resource: GearResource, is_shop: bool = false) -> void:
	display_name.visible = true
	icon.visible = true
	display_name.text = gear_resource.gearName
	icon.modulate = gear_resource.color
	label.text = gear_resource.description
	icon.texture = gear_resource.icon
	if gear_resource.isConsumable:
		permanent_panel.visible = false
	else:
		permanent_panel.visible = true
	if is_shop:
		price.text = "$" + str(gear_resource.buyValue)
	else:
		price.visible = false

func set_sfx_info(sfx_resource: StatusEffectResource) -> void:
	display_name.visible = true
	icon.visible = true
	display_name.text = sfx_resource.name
	label.text = sfx_resource.description
	icon.texture = sfx_resource.icon

	
