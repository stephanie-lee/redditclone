module ApplicationHelper
  def auth_token
    html = <<-HTML
      <input type="hidden"
             name="authenticity_token"
             value="#{form_authenticity_token}">
    HTML

    html.html_safe
  end

  def ensure_http(url)
    if url[0..3] == "http"
      url
    else
      "http://" + url
    end
  end
end
