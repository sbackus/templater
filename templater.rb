require 'json'

def templater(template, json)

	tags = template.scan(/<\*.*?\*>/)
 	for tag in tags
 		replacement = get_data(json, tag[2..-3].strip.split("."))
 		template.gsub!(tag, replacement)
	end
	return template
end


def get_data(json, path_to_data)
	first = path_to_data.first
	if path_to_data.length == 1
		return json[first]
	else
		return get_data(json[first], path_to_data[1..-1])
	end
end