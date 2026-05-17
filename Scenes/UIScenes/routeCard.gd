extends Panel
class_name RouteCard

@onready var title: RichTextLabel = $MarginContainer/PanelContainer/VBoxContainer/PanelContainer/Title
@onready var icon: TextureRect = $MarginContainer/PanelContainer/VBoxContainer/MarginContainer2/TextureRect
@onready var description: RichTextLabel = $MarginContainer/PanelContainer/VBoxContainer/MarginContainer/Description

var panelResource: PanelResource
var cardRoundManager: RoundManager

func initialize(round_manager: RoundManager, initPanelResource: PanelResource) -> void:
	self.cardRoundManager = round_manager
	self.panelResource = initPanelResource
	title.text = initPanelResource.panelTitle
	description.text = initPanelResource.description

func onButtonClick() -> void:
	self.cardRoundManager.transitionState(panelResource.stateName)
