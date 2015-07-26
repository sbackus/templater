require './src/nodes/node'
class TextNode
  include Node
  def render(context)
    return @token
  end
end