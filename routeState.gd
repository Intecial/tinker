extends RoundState
class_name RouteState



func onEnter(roundManager: RoundManager) -> void:
	var routePanel: RoutePanel = Constant.PANEL_MANAGER.getPanel("Route")
	routePanel.initializeRoutes(roundManager)
	Constant.PANEL_MANAGER.switchPanel("Route")
	
func onExit(roundManager: RoundManager) -> void:
	pass
