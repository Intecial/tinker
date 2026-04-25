extends ActionResource
class_name DamageActionOnStatAction
enum StatType {HEALTH, SHIELD, KNOWLEDGE}
@export var stat : StatType
@export var action: DamageAction

func execute(actor: Actor) -> void:
	action.damage = self.resolveType(Constant.PLAYER, stat)
	print(action.damage)
	action.execute(actor)
	await flash(Constant.FX_LAYER)
	

func resolveType(actor: Actor, statUsed: StatType) -> int:
	var statMap : Dictionary[StatType, int]= {
		StatType.HEALTH: actor.health,
		StatType.SHIELD: actor.shield,
		StatType.KNOWLEDGE: actor.knowledge
	}
	return statMap.get(statUsed, 0)

func flash(layer: FXLayer) -> void:
	var rect : ColorRect = ColorRect.new()
	rect.color = Color.RED
	rect.anchor_right = 1.0
	rect.anchor_bottom = 1.0
	layer.add_child(rect)
	
	var tween : Tween = layer.create_tween()
	tween.tween_property(rect, "color:a", 0.0, animSpeed)
	tween.tween_callback(func() -> void: onFlashDone(rect)) 
	
	await tween.finished


func onFlashDone(rect: ColorRect) -> void:
	rect.queue_free()
	pass
