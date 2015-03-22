module ALittleHelp

  def render_partial( partial_name )
    partial "partials/#{partial_name}"
  end

  def page_title
  	current_page.data.title ?  "#{current_page.data.title} | Steven Sloan" : data.global.title
  end

end
