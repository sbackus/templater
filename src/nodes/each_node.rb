require './src/nodes/node'
class EachNode
  include Node
  def render(context)
    path_to_data = @token.split(" ")[1]
    variable_name = @token.split(" ")[2]
    unless context.nil?
      new_context = context.clone
      array = get_data(context, path_to_data.split("."))
      unless array.nil?
        return array.map do |var|
          new_context[variable_name] = var
          render_children(new_context)
        end.join
      end
    end
  end
end