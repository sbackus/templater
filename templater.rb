
require './nodes.rb'
require './compiler.rb'

class Templater

  def self.render (template, data)
    syntaxTree = Compiler.new(template).compile
    syntaxTree.render(data)
  end

end


