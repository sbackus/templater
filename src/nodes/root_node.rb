class RootNode

  include Node

  def render(context)
    render_children(context)
  end

end