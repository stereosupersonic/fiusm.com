class Arena::Action < Arena::HtmlView

  include Arena::HtmlViewExtensions::Context

  def initialize(context, assigns = {}, options = {})
    @context = context
    @assigns = assigns
    super(options)
  end

end