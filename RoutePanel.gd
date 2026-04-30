extends GamePanel
class_name RoutePanel

@onready var routeContainer: HBoxContainer = $RouteContainer
@export var routeCard: PackedScene 

func initializeRoutes(roundManager: RoundManager) -> void:
	for i: Node in routeContainer.get_children():
		i.queue_free()
	var panels: Array[GamePanel] = []
	for panelKeys: String in Constant.PANEL_MANAGER.panelDictionary.keys():
		if panelKeys != "Route":
			panels.append(Constant.PANEL_MANAGER.getPanel(panelKeys))
	var utilityPanels: Array[GamePanel] = panels.filter(func(p: GamePanel) -> bool: return p.panelResource.panelType == PanelResource.PanelType.UTILITY)
	var combatPanels: Array[GamePanel] = panels.filter(func(p: GamePanel) -> bool: return p.panelResource.panelType == PanelResource.PanelType.COMBAT)
	
	var firstPanel: GamePanel = utilityPanels.pick_random()
	var secondPanel: GamePanel = combatPanels.pick_random()
		
	var firstCard: RouteCard = routeCard.instantiate()
	var secondCard: RouteCard = routeCard.instantiate()
	routeContainer.add_child(firstCard)
	routeContainer.add_child(secondCard)
	firstCard.initialize(roundManager, firstPanel.panelResource)
	secondCard.initialize(roundManager, secondPanel.panelResource)
	
	
