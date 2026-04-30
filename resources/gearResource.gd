extends Resource
class_name GearResource

enum GearType { DAMAGE, SHIELD, HEAL, MONEY }

@export var gearName: String = ""
@export var gearType: GearType = GearType.DAMAGE
@export var icon: Texture2D
@export var actions: Array[ActionResource]
@export var color: Color
@export var isConsumable: bool = false

@export_category("Shop")
@export var buyValue: int = 0
@export var sellValue: int = 0

@export_multiline var description: String = ""

func evaluate(target: Actor) -> void:
	for action: ActionResource in actions:
		await action.execute(target)