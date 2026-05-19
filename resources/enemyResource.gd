extends Resource
class_name EnemyResource

@export var name: String = ""
@export var health: int = 100
@export var gears: Array[GearResource] = []
@export var permanent_actions: Array[ActionResource] = []
@export var icon: Texture 
@export var enemy_state_machine: PackedScene