class Compiler

  def self.compile(tokens)
    root_node = RootNode.new(nil)
    context_stack = [root_node]
    tokens.each do |token|
      if token.new_context?
        new_node = token.create_node
        add_child_to_tree(new_node, context_stack.last)
        context_stack.push(new_node)
      elsif token.end_context?
        context_stack.pop
      else
        add_child_to_tree(token.create_node, context_stack.last)
      end
    end
    return root_node
  end

private
  def self.add_child_to_tree(new_node, parent_node)
    parent_node.children << new_node
  end

end