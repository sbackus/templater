require 'json'

class Templater

  def initialize(template)
    @template = template
    @root = Compiler.new(template).compile()
  end

	def render(json)
		@root.render(json)
	end
end

class Compiler
	TAG_START = '<\*'
	TAG_END = '\*>'
	TAG_REGEX = /(#{TAG_START}.*?#{TAG_END})/
	def initialize(template)
		@template = template
	end

	def get_tokens()
		@template.split(TAG_REGEX)
	end

	def compile
    root_node = Node.new(@template)
    get_tokens().each do |token|
        new_node = create_node(token)
        root_node.children << new_node
    end
    return root_node
	end

	def create_node(token)
		if token =~ TAG_REGEX
			return VariableNode.new(token[2...-2].strip)
		else
			return TextNode.new(token)
		end
	end

end

class Node

	attr_accessor :children

	def initialize(token)
		@token = token
		@children = []
	end

	def render(context)
		@children.map do |child_node|
			child_node.render(context)
		end.join
	end
end

class VariableNode < Node
	def render(context)
		get_data(context, @token.split("."))
	end
end

class TextNode < Node
	def render(context)
		return @token
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