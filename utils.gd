static func init():
	randomize()


static func pick(array):
	return array[randi() % len(array)]


static func load_json_resource(path):
	var f = File.new()
	var err = f.open("res://"+path, File.READ)
	if err != OK:
		printerr("Could not open '%s', error code " % path, err)
		return null
	var json_parse = JSON.parse(f.get_as_text())
	f.close()
	if json_parse.error != OK:
		printerr("JSON error '%s' on line '%d' of '%s'" % [json_parse.error_string, json_parse.error_line, path])
		return null
	return json_parse.result


static func generate_name(names):
	pass


