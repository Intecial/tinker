extends Node
class_name Actor

@export var isPlayer : bool = false
@export var maxHealth: int = 100
var target: Actor
@export var statusEffects: Array[StatusEffectResource] = []
@onready var actorContext: ActorContext = $ActorContext

signal on_status_effects_changed(arr: Array[StatusEffectResource])

var _health: int = 100
var health: int:
	get:
		return _health
	set(value):
		_health = value
		health_changed.emit(value)
signal health_changed(value: int)

var _shield: int = 0
var shield: int:
	get:
		return _shield
	set(value):
		_shield = value
		shield_changed.emit(value)
signal shield_changed(value: int)

var _knowledge: int = 0
var knowledge: int:
	get:
		return _knowledge
	set(value):
		_knowledge = value
		print("Shield Added")
		knowledge_changed.emit(value)
signal knowledge_changed(value: int)
signal onDeath

signal on_damage(value: int)
func _ready() -> void:
	if isPlayer:
		Constant.PLAYER = self
	actorContext.init(self)
	print("initializing actor context"+ str(actorContext))
	await get_tree().process_frame
	health_changed.emit(_health)
	shield_changed.emit(_shield)
	knowledge_changed.emit(knowledge)
	
func addHealth(amt: int) -> void:
	health += amt
	if health > maxHealth:
		health = maxHealth

func hurtHealth(amt: int) -> void:
	health -= amt
	if health <= 0:
		health = 0
		onDeath.emit()
		self.queue_free()

func resolveDamage(amt: int) -> void:
	if shield > 0:
		var overflow : int = amt - shield
		hurtShield(amt)
		if overflow > 0:
			hurtHealth(overflow)
	else:
		hurtHealth(amt)
	on_damage.emit(amt)

func dealDamage(amt: int) -> void:
	print("Player Dealing Damage")
	var extra_damage: int = actorContext.try_get_data("extra_damage") if actorContext.try_get_data("extra_damage") else 0
	var damage: int = amt + extra_damage
	var mult_damage: float = actorContext.try_get_data("damage_multiplier") if actorContext.try_get_data("damage_multiplier") else 1.0
	damage = int(damage * mult_damage)
	print(damage)
	target.resolveDamage(damage)
	
func hurtShield(amt: int) -> void:
	shield -= amt
	if shield < 0:
		shield = 0

func addShield(amt: int) -> void:
	shield += amt

func addKnowledge(amt: int) -> void:
	knowledge += amt

func useKnowledge(amt: int) -> bool:
	if knowledge >= amt:
		knowledge -= amt
		return true
	return false
	
func perform_gear(gear: GearResource) -> void:	
	await gear.evaluate(self)

# Upkeep
func upkeep() -> void:
	triggerStatusEffects(true)
	if isPlayer:
		print("PLayer Upkeep")
	else:
		print("Enemy Upkeep")
		print(actorContext.persitent_data)
		print(actorContext.try_get_data("maintain_shields"))
		print(!actorContext.try_get_data("maintain_shields"))
	if !actorContext.try_get_data("maintain_shields"):
		resetShields()

func resetShields() -> void:
	if shield == 0:
		return
	shield = 0

func triggerStatusEffects(is_upkeep: bool = false) -> void:
	if !isPlayer:
		print("Enemy Before Reset")
		print(actorContext.persitent_data)
	actorContext.reset()
	if !isPlayer:
		print("Enemy After Reset")
		print(actorContext.persitent_data)
	for sfx: StatusEffectResource in statusEffects:
		sfx.evaluate(actorContext)
		if is_upkeep and !sfx.is_permanent:
			statusEffects.erase(sfx)
	on_status_effects_changed.emit(statusEffects)

func add_status_effect(status_effect: StatusEffectResource) -> void:
	statusEffects.append(status_effect)
	on_status_effects_changed.emit(statusEffects)
