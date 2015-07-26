class Compiler

  TAG_START = '<\*'
  TAG_END = '\*>'
  TAG = /(#{TAG_START}.*?#{TAG_END})/
  END_EACH = /(#{TAG_START}\WENDEACH\W#{TAG_END})/
  START_EACH = /(#{TAG_START}\WEACH.*?#{TAG_END})/

  def self.compile(tokens)
    root_node = RootNode.new(nil)
    context_stack = [root_node]
    tokens.each do |token|
      if token.new_context?
        new_node = add_child_to_tree(token, context_stack)
        context_stack.push(new_node)
      elsif token.end_context?
        context_stack.pop
      else
        add_child_to_tree token, context_stack
      end
    end
    return root_node
  end

private
  def self.add_child_to_tree(token, context_stack)
    new_node = token.create_node
    context_node = context_stack.last
    context_node.children << new_node
    new_node
  end

end