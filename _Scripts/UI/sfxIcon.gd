extends Control
class_name SfxIcon


@onready var icon: TextureRect = $TextureRect
@onready var amount: RichTextLabel = $Control/RichTextLabel

@export var sfx_resource: StatusEffectResource


func _ready() -> void:
	init_sfx(sfx_resource)
func init_sfx(resource: StatusEffectResource) -> void:
	sfx_resource = resource
	icon.texture = resource.icon
	
func set_amount(amt: int) -> void:
	amount.text = str(amt)