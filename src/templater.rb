Dir[File.dirname(__FILE__) + '/nodes/*.rb'].each {|file| require file }
require_relative 'compiler'
require_relative 'tokenizer'

class Templater

  def self.render (template, data)
    tokens = Tokenizer.get_tokens(template)
    syntaxTree = Compiler.compile(tokens)
    syntaxTree.render(data)
  end

end


