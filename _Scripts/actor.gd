extends Node
class_name Actor

@export var isPlayer : bool = false
@export var maxHealth: int = 100
var target: Actor
var statusEffects: Array[StatusEffectResource] = []

var _health: int = 35
var health: int:
	get:
		return _health
	set(value):
		_health = value
		print("Health Added")
		health_changed.emit(value)
signal health_changed(value: int)

var _shield: int = 0
var shield: int:
	get:
		return _shield
	set(value):
		_shield = value
		print("Shield Added")
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


func _ready() -> void:
	if isPlayer:
		Constant.PLAYER = self
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

func resetShields() -> void:
	if shield == 0:
		return
	shield = 0
	
func triggerStatusEffects() -> void:
	for sfx: StatusEffectResource in statusEffects:
		sfx.evaluate(self)