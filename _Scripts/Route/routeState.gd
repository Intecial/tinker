extends RoundState
class_name RouteState

@export var route_parent: RouteScene


func onEnter(roundManager: RoundManager) -> void:
#	roundManager.mainUI.visible = false
	if Constant.ROUTE_GENERATOR.is_last_route():
		Constant.ROUTE_GENERATOR.regenerate()
	route_parent.visible = true
#	route_parent.recenter()
#	var routePanel: RoutePanel = Constant.PANEL_MANAGER.getPanel("Route")
#	routePanel.initializeRoutes(roundManager)
#	Constant.PANEL_MANAGER.switchPanel("Route")
	
func onExit(roundManager: RoundManager) -> void:

#	roundManager.mainUI.visible = true
	route_parent.visible = false
	pass
