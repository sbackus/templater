require './src/nodes/node'
class VariableNode
  include Node
  def render(context)
    get_data(context, @token.path_to_data)
  end
end