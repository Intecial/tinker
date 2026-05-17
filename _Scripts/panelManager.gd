extends Node
class_name PanelManager
@onready var shopPanel: GamePanel = $VBoxContainer/ShopPanel
@onready var forgePanel: GamePanel = $VBoxContainer/ForgePanel
@onready var routePanel: GamePanel = $VBoxContainer/RoutePanel
@onready var enemyPanel: GamePanel = $VBoxContainer/EnemyPanel
var panelDictionary: Dictionary[String, GamePanel] = {
}

func _enter_tree() -> void:
	Constant.PANEL_MANAGER = self
	
func _ready() -> void:
	panelDictionary = {
		"Shop": shopPanel,
		"Forge": forgePanel,
		"Route": routePanel,
		"Enemy": enemyPanel
	}

func switchPanel(key: String) -> void:
	hideAllPanel()
	showPanel(key)

func getPanel(key: String) -> GamePanel:
	return panelDictionary.get(key)

func showPanel(key: String) -> void:
	if panelDictionary.get(key):
		var panel : GamePanel = panelDictionary.get(key)
		panel.show()
		
	
func hideAllPanel() -> void:
	for key: String in panelDictionary.keys():
		var panel : GamePanel = panelDictionary.get(key)
		panel.hide()
	