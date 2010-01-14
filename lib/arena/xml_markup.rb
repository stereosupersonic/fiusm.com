class Arena::XmlMarkup < Builder::XmlMarkup
  def _text(text)
    @target << (text.respond_to?(:to_html) ? text.to_html : text)
  end
end