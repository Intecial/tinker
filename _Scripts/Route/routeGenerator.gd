extends Node2D
class_name RouteGenerator

@export var route_icon : PackedScene
@export var num_of_node: int = 5
@export var tree_height: int = 5
@export var horizontal_spacing: float = 100.0
@export var vertical_spacing: float = 120.0

var routes: Array[RouteResource]

func _ready() -> void:
	var dict: Dictionary = await ResourceFolderLoader.load_folder("res://resources/Routes/")
	for key: String in dict.keys():
		routes.append(dict.get(key))
	generate_routes()
	

func generate_routes() -> void:
	var root: RouteIcon = route_icon.instantiate()
	add_child(root)
	root.route_resource = routes.pick_random()
	root.init()
	root.position = Vector2(horizontal_spacing, vertical_spacing)
	root.is_root = true
	
	var current_node: RouteIcon = root
	for height: int in range(tree_height):
		var child: RouteIcon = route_icon.instantiate()
		add_child(child)
		child.route_resource = routes.pick_random()
		child.init()
		child.position = Vector2(current_node.position.x, (height + 1) * vertical_spacing)
		
		current_node.add_child_route(child)
		current_node = child
