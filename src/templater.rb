Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each {|file| require file }
require_relative 'compiler'

class Templater

  def self.render (template, data)
    syntaxTree = Compiler.new(template).compile
    syntaxTree.render(data)
  end

end


