@tool extends ColorRect
@export var scene_list:GridContainer
var tools:PackedStringArray
func _ready() -> void:
	get_tools()
	add_tools()
	DisplayServer.screen_set_orientation(DisplayServer.SCREEN_SENSOR)
	print(tools)
func get_tools(path:String="res://"):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if dir.current_is_dir():
				get_tools(path+file_name+"/")
			else:
				if file_name.contains("_main"):
					tools.append(path+file_name)
			file_name = dir.get_next()
func add_tools(tool:PackedStringArray=tools):
	if OS.has_feature("editor"):
		for t in tool:
			var b:=Button.new()
			ResourceLoader.load_threaded_request(t)
			ResourceLoader.load_threaded_get_status(t)
			b.pressed.connect(get_tree().change_scene_to_file.call_deferred.bind(t))
			b.text=t.get_file().trim_suffix("_main."+t.get_extension()).capitalize()
			b.add_theme_font_size_override("font_size",28)
			b.size_flags_horizontal=Control.SIZE_EXPAND_FILL
			scene_list.add_child(b)
	else:
		var new:PackedStringArray
		for t in tool:
			new.append(t.trim_suffix(".remap"))
		for n in new:
			var b:=Button.new()
			ResourceLoader.load_threaded_request(n)
			ResourceLoader.load_threaded_get_status(n)
			b.pressed.connect(get_tree().change_scene_to_file.call_deferred.bind(n))
			b.text=n.get_file().trim_suffix("_main."+n.get_extension()).capitalize()
			b.add_theme_font_size_override("font_size",28)
			b.size_flags_horizontal=Control.SIZE_EXPAND_FILL
			scene_list.add_child(b)
	var qb:=Button.new()
	qb.text="QUIT"
	qb.add_theme_font_size_override("font_size",28)
	qb.pressed.connect(get_tree().quit)
	scene_list.add_child(qb)
