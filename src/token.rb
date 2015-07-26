class Token

  TAG_START = '<\*'
  TAG_END = '\*>'
  TAG = /(#{TAG_START}.*?#{TAG_END})/
  END_EACH = /(#{TAG_START}\WENDEACH\W#{TAG_END})/
  START_EACH = /(#{TAG_START}\WEACH.*?#{TAG_END})/

  attr_reader :fragment

  def initialize(fragment)
    @fragment = fragment
  end

  def new_context?
    @fragment =~ START_EACH
  end

  def end_context?
    @fragment =~ END_EACH
  end

  def path_to_data
    if @fragment =~ START_EACH
      clean(@fragment).split(" ")[1].split(".")
    elsif @fragment =~ TAG
      clean(@fragment).split(".")
    else
      []
    end
  end

  def to_s
    @fragment
  end

  def variable_name
    clean(@fragment).split(" ")[2]
  end

  def clean(token)
    token[2...-2].strip
  end

  def create_node
    if @fragment =~ START_EACH
      return EachNode.new self
    elsif @fragment =~ TAG
      return VariableNode.new self
    else
      return TextNode.new self
    end
  end
end