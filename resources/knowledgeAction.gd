extends ActionResource
class_name KnowledgeAction

@export var knowledge: int = 5
func execute(actor: Actor):
	actor.addKnowledge(knowledge)
