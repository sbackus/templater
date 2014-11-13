class Node

  attr_accessor :children

  def initialize(token)
    @token = token
    @children = []
  end

  def render(context)
    render_children(context)
  end

  protected

  def render_children(context)
    @children.map do |child_node|
      child_node.render(context)
    end.join
  end

  def get_data(json, path_to_data)
    first = path_to_data.first
    if path_to_data.length == 1
      return json[first]
    else
      return get_data(json[first], path_to_data[1..-1])
    end
  end
end

class EachNode < Node
  def render(context)
    path_to_data = @token.split(" ")[1]
    variable_name = @token.split(" ")[2]
    answer = ""
    unless context.nil?
      new_context = context.clone
      array = get_data(context, path_to_data.split("."))
      unless array.nil?
        return array.map do |var|
          new_context[variable_name] = var
          render_children(new_context)
        end.join
      end
    end
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