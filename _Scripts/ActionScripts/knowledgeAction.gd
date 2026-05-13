extends ActionResource
class_name KnowledgeAction

@export var knowledge: int = 5
func execute(actor: Actor) -> void:
	actor.addKnowledge(knowledge)
