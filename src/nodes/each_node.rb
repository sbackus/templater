require './src/nodes/node'
class EachNode
  include Node
  def render(context)
    data = get_data(context, @token.path_to_data) || []
    return data.map do |var|
      context[@token.variable_name] = var
      render_children(context)
    end.join
  end
end