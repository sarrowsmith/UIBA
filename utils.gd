static func init():
	randomize()


static func pick(array):
	return array[randi() % len(array)]


static func load_tsv_resource(path):
	var f = File.new()
	var err = f.open("res://%s.tsv"%path, File.READ)
	if err != OK:
		printerr("Could not open '%s', error code " % path, err)
		return null
	var result = {}
	var psa = f.get_csv_line("\t")
	while not f.eof_reached():
		var type = psa[0]
		psa.invert()
		if result.has(type):
			result[type].append(psa)
		else:
			result[type] = [psa]
		psa = f.get_csv_line("\t")
	return result


static func generate_name(names):
	var adjective = pick(names["adjective"])
	var noun = pick(names["noun"])
	var values = ["%s-%s", "%s\n%s", "%s%s"]
	for i in 3:
		values[i] = values[i] % [adjective[i], noun[i]]
	return values
