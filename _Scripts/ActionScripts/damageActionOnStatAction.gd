extends ActionResource
class_name DamageActionOnStatAction
enum StatType {HEALTH, SHIELD, KNOWLEDGE}
@export var stat : StatType
@export var action: DamageAction

func execute(actor: Actor) -> void:
	action.damage = self.resolveType(Constant.PLAYER, stat)
	print(action.damage)
	action.execute(actor)

func resolveType(actor: Actor, statUsed: StatType) -> int:
	var statMap : Dictionary[StatType, int]= {
		StatType.HEALTH: actor.health,
		StatType.SHIELD: actor.shield,
		StatType.KNOWLEDGE: actor.knowledge
	}
	return statMap.get(statUsed, 0)
