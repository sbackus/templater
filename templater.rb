require 'json'

class Templater

  def initialize(template)
    @template = template
  end

	def render(json)
		tag_regex = /<\*.*?\*>/
		tags = @template.scan(tag_regex)
	 	for tag in tags
	 		replacement = get_data(json, tag[2..-3].strip.split("."))
	 		@template.gsub!(tag, replacement)
		end
		return @template
	end
end



def get_data(json, path_to_data)
	first = path_to_data.first
	if path_to_data.length == 1
		return json[first]
	else
		return get_data(json[first], path_to_data[1..-1])
	end
end