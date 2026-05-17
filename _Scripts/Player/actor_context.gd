extends Node
class_name ActorContext

var data : Dictionary[String, Variant] = {

}

var persitent_data : Dictionary[String, Variant] = {

}

var actor: Actor

func init(init_actor: Actor) -> void:
	actor = init_actor

func try_get_data(key: String) -> Variant:
	if data.has(key):
		return data.get(key)
	return false
	
func try_get_persistent_data(key: String) -> Variant:
	if persitent_data.has(key):
		return persitent_data.get(key)
	return false
	

func set_data(key: String, value: Variant) -> void:
	data.set(key, value)

func set_persistent_data(key: String, value: Variant) -> void:
	persitent_data.set(key, value)

func remove_data(key: String) -> void:
	if try_get_data(key):
		persitent_data.erase(key)

func remove_persistent_data(key: String) -> void:
	if try_get_data(key):
		data.erase(key)	
func reset() -> void:	
	print("Actor Clearing Context")
	data.clear()
