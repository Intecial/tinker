extends ActionResource
class_name ShieldActionOnStatAction
enum StatType {HEALTH, SHIELD, KNOWLEDGE}
@export var stat : StatType
@export var action: ShieldAction

func execute(actor: Actor) -> void:
	action.shieldAmount = self.resolveType(Constant.PLAYER, stat)
	action.execute(actor)

func resolveType(actor: Actor, statUsed: StatType) -> int:
	var statMap : Dictionary[StatType, int]= {
		StatType.HEALTH: actor.health,
		StatType.SHIELD: actor.shield,
		StatType.KNOWLEDGE: actor.knowledge
	}
	return statMap.get(statUsed, 0)