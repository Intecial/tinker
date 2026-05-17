extends Control
class_name EnemyUI

@onready var enemy_stat_container: EnemyStatView = $HBoxContainer/VBoxContainer/EnemyStatContainer

@onready var enemy_sfx_container: EnemySfxContainer = $HBoxContainer/SfxContainer
@onready var enemy_slot: GearArraySlot = $HBoxContainer/VBoxContainer/PanelContainer/VBoxContainer/EnemySlot
var target: EnemyActor
func connect_actor(enemy_actor: EnemyActor) -> void:
	self.target = enemy_actor
	enemy_stat_container.connectTarget(enemy_actor)
	
	enemy_actor.gear_prepared.connect(renderGear)
	enemy_actor.on_gear_performed.connect(popGear)
	enemy_sfx_container.init_cont(enemy_actor)

func _exit_tree() -> void:
	target.gear_prepared.disconnect(renderGear)
	target.on_gear_performed.disconnect(popGear)

func popGear() -> void:
	enemy_slot.removeGear()

func renderGear(gear: GearResource) -> void:
	enemy_slot.setGear(gear)
	
