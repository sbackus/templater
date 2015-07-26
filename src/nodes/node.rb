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