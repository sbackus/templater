require_relative 'token'
class Tokenizer

  def self.get_tokens(template)
    template.split(Token::TAG).map do |fragment|
      Token.new(fragment)
    end
  end

end