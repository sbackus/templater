require './src/nodes/node'
class TextNode < Node
  def render(context)
    return @token
  end
end