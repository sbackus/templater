require 'json'

def templater(template, data)

	tags = template.scan(/<\*.*\*>/)
 	for tag in tags
 		replacement = data[tag[2..-3].strip]
 		template.gsub!(tag, replacement)
	end
	return template
end