ActionView::Base.field_error_proc = proc do |html_tag, _instance|
  doc = Nokogiri::HTML::DocumentFragment.parse(html_tag)
  field = doc.at("input, select, textarea")
  if field
    existing = field["class"] || ""
    field["class"] = "#{existing} is-invalid".strip
    doc.to_html.html_safe
  else
    html_tag
  end
end