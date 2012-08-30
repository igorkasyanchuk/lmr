Forem::FormattingHelper.class_eval do
  def as_formatted_html(text)
    simple_format(raw(text))
  end
  
end