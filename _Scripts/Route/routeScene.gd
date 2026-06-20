extends Node2D
class_name RouteScene

@export var cameraScriptPS: PackedScene
@export var routeGeneratorPS: PackedScene

var cameraScript: RouteParent = null
var routeGenerator: RouteGenerator = null
func initialize_scene() -> void:
	instantiate_children()
	initialize_children()
	
func instantiate_children() -> void:
	cameraScript = cameraScriptPS.instantiate()
	routeGenerator = routeGeneratorPS.instantiate()
	
	add_child(cameraScript)
	add_child(routeGenerator)

func initialize_children() -> void:
#	routeGenerator.player_sprite = playerIcon
	cameraScript.root = self
	routeGenerator.generate_routes()
	pass


func _ready() -> void:
	initialize_scene()
