extends RouteResource
class_name StateRoute

@export var state_to_move: String

func evaluate() -> void:
	Constant.ROUND_MANAGER.transitionState(state_to_move)
