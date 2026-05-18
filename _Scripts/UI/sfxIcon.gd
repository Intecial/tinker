extends Control
class_name SfxIcon


@onready var icon: TextureRect = $TextureRect
@onready var amount: RichTextLabel = $NinePatchRect/Control/RichTextLabel

@export var sfx_resource: StatusEffectResource
@export var tooltipManager: ToolTipManager


func _ready() -> void:
	init_sfx(sfx_resource)

func init_sfx(resource: StatusEffectResource) -> void:
	sfx_resource = resource
	icon.texture = resource.icon
	tooltipManager.sfx_resource = sfx_resource
	
func set_amount(amt: int) -> void:
	amount.text = str(amt) if amt > 1 else ""
