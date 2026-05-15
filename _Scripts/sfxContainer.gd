extends HBoxContainer
class_name SfxContainer

@export var sfx_icon: PackedScene
func _ready() -> void:
	Constant.PLAYER.on_status_effects_changed.connect(populate_sfx_icons)
	
func _exit_tree() -> void:
	Constant.PLAYER.on_status_effects_changed.disconnect(populate_sfx_icons)
	
func populate_sfx_icons(arr: Array[StatusEffectResource]) -> void:
	clear_children()
	for stat: StatusEffectResource in arr:
		var sfx_obj: SfxIcon = sfx_icon.instantiate()
		self.add_child(sfx_obj)
		sfx_obj.init_sfx(stat)

func clear_children() -> void:
	for child: Node in get_children():
		child.queue_free()
