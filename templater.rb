require 'json'

def templater(template, json)

	tags = template.scan(/<\*.*?\*>/)
 	for tag in tags
 		replacement = get_data(json, tag[2..-3].strip)
 		template.gsub!(tag, replacement)
	end
	return template
end


def get_data(json, path_to_data)
	names = path_to_data.split(".")
	first = names.first
	if names.length == 1
		return json[first]
	else
		return get_data(json[first], names[1..-1].join("."))
	end
end