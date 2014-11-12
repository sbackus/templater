require 'pry'
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
	END_EACH = /(#{TAG_START}\WENDEACH\W#{TAG_END})/
	START_EACH = /(#{TAG_START}\WEACH.*?#{TAG_END})/
	def initialize(template)
		@template = template
	end

	def get_tokens()
		@template.split(TAG_REGEX)
	end

	def compile
    root_node = Node.new(@template)
    context_stack = [root_node]
    get_tokens().each do |token|
			if token =~ END_EACH
				context_stack.pop
			elsif token =~ START_EACH
				new_node = create_node(token)
				context_node = context_stack[-1]
      	context_node.children << new_node
      	context_stack.push(new_node)
			else
	      new_node = create_node(token)
	      context_node = context_stack[-1]
	      context_node.children << new_node
	    end
    end
    return root_node
	end

	def create_node(token)
		if token =~ TAG_REGEX
			if token.include? 'EACH'
				return EachNode.new(token[2...-2].strip)
			else
				return VariableNode.new(token[2...-2].strip)
			end
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

class EachNode < Node
	def render(context)
		path_to_data = @token.split(" ")[1]
		variable_name = @token.split(" ")[2]
		answer = ""
		if context
			new_context = context.clone
			get_data(context, path_to_data.split(".")).each do |var|
				new_context[variable_name] = var
				answer += @children.map do |child_node|
					child_node.render(new_context)
				end.join
			end
		end
		return answer
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
	#TODO can I move the split inside here an have path_to_data be a dotted string?
	first = path_to_data.first
	if path_to_data.length == 1
		return json[first]
	else
		return get_data(json[first], path_to_data[1..-1])
	end
end
