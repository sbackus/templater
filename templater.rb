
require './nodes.rb'
require './compiler.rb'

class Templater

  def initialize(template)
    @template = template
    @root = Compiler.new(template).compile
  end

  def render(data)
    @root.render data
  end
end


