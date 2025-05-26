class Marksmith::Renderer
  def initialize(body:)
    @body = body
  end

  def render
    Commonmarker.to_html(@body, options: {
      render: { unsafe: true }
    })
  end
end
