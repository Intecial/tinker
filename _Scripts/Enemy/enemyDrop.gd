extends Control
class_name EnemyDrop

var enemy: EnemyResource
@export var drop_slot: GearArraySlot
@export var skip_button: Button
func init_drop(enemy_resource: EnemyResource) -> void:
	self.enemy = enemy_resource
	var random_gear: GearResource = enemy_resource.gears.pick_random()
	drop_slot.setGear(random_gear)