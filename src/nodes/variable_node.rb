require './src/nodes/node'
class VariableNode < Node
  def render(context)
    get_data(context, @token.split("."))
  end
end