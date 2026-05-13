class_name ResourceFolderLoader

static func load_folder(folder_path: String) -> Dictionary:
	var resources: Dictionary = {}
	var paths_to_load: Array = []

	var dir : DirAccess = DirAccess.open(folder_path)
	if not dir:
		return resources

	dir.list_dir_begin()
	var file_name : String = dir.get_next()

	while file_name != "":
		if not dir.is_current_is_dir():
			var full_path : String= folder_path + "/" + file_name
			paths_to_load.append(full_path)
			ResourceLoader.load_threaded_request(full_path)
		file_name = dir.get_next()

	dir.list_dir_end()

	for path : String in paths_to_load:
		var resource :Resource = await _await_resource(path)
		resources[path] = resource

	return resources

static func _await_resource(path: String) -> Resource:
	while true:
		var status :int = ResourceLoader.load_threaded_get_status(path)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			return ResourceLoader.load_threaded_get(path)
		elif status == ResourceLoader.THREAD_LOAD_FAILED:
			push_error("Failed to load: " + path)
			return null
		await get_tre.process_frame
	return null