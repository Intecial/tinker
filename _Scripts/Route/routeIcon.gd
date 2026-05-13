extends Area2D
class_name RouteIcon

@onready var route_sprite :Sprite2D = $RouteSprite
@export var route_resource: RouteResource

var child_routes: Array[RouteIcon]
var is_root : bool = false
	
func init() -> void:
	route_sprite.texture = route_resource.route_icon

func evaluate_route() -> void:
	route_resource.evaluate()

func add_child_route(child_route: RouteIcon) -> void:
	child_routes.append(child_route)
