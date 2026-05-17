extends RoundState
class_name RouteState

@export var route_parent: RouteParent


func onEnter(roundManager: RoundManager) -> void:
#	roundManager.mainUI.visible = false
	route_parent.visible = true
#	var routePanel: RoutePanel = Constant.PANEL_MANAGER.getPanel("Route")
#	routePanel.initializeRoutes(roundManager)
#	Constant.PANEL_MANAGER.switchPanel("Route")
	
func onExit(roundManager: RoundManager) -> void:

#	roundManager.mainUI.visible = true
	route_parent.visible = false
	pass
