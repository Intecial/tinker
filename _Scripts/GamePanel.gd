extends Control
class_name GamePanel

@export var panelResource: PanelResource

func hidePanel() -> void:
	self.visible = false
	
func showPanel() -> void:	
	self.visible = true