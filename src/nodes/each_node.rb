require './src/nodes/node'
class EachNode
  include Node
  def render(context)
    unless context.nil?
      new_context = context.clone
      array = get_data(context, @token.path_to_data)
      unless array.nil?
        return array.map do |var|
          new_context[@token.variable_name] = var
          render_children(new_context)
        end.join
      end
    end
  end
end