extends PanelContainer
class_name ActionLabel

@export var toolTipScene: PackedScene
func _make_custom_tooltip(for_text: String) -> Object:
	var toolTip : ToolTip = toolTipScene.instantiate()
	toolTip.setText(for_text)
	return toolTip
