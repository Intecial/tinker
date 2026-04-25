extends Control
class_name Stat

@export var icon: Texture2D
@export var color: Color
@onready var label: Label = $CenterContainer/Label
@onready var textureRect: TextureRect = $TextureRect
@onready var explosion: ExplosionOnGear = $GPUParticles2D
var currentTween: Tween

func _ready() -> void:
	textureRect.texture = icon
	textureRect.modulate = color
	await get_tree().process_frame
	
	explosion.position = textureRect.size / 2
	

func render(value: int) -> void:
	self.label.text = str(value)
	await get_tree().create_timer(0.2).timeout
	explosion.burst(color)
