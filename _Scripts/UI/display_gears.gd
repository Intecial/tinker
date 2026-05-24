extends PanelContainer
class_name DisplayGears

@export var gear_display_container: PackedScene
@export var gear_container: GridContainer
@export var gears_to_show: Array[GearResource]

var is_open: bool = false
func init_display(gears: Array[GearResource]) -> void:
	gears_to_show = gears.duplicate_deep(true)
	for gear: GearResource in gears_to_show:
		var cont: GearDisplayContainer = gear_display_container.instantiate()
		gear_container.add_child(cont)
		cont.init_container(gear)

func on_show() -> void:
	self.visible = true
	init_display([])
	is_open = true
	init_display(Constant.PLAYER.gear_pouch.discarded_gears)
	
func toggle_button() -> void:
	if is_open:
		on_hide()
	else:
		on_show()

func on_hide() -> void:
	for child : Node in gear_container.get_children():
		child.queue_free()
	self.visible = false
	is_open = false
