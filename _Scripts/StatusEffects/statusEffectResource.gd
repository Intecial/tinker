@abstract
extends Resource
class_name StatusEffectResource

@export var icon: Texture
@export var name: String	
@export var is_permanent: bool

@export_multiline var description: String
#@export var actions: Array[ActionResource] = []
@abstract
func evaluate(actor_context: ActorContext) -> void