module CustomHelpers

  def versioned_script( script_name )
    tag = javascript_include_tag "#{script_name}"
    tag.gsub('<script src="', '').gsub('" type="text/javascript"></script>', '')
  end

  def render_partial( partial_name )
    partial "partials/#{partial_name}"
  end

  def page_title
  	current_page.data.title ?  "#{current_page.data.title} | Steven Sloan" : data.global.title
  end

  def page_class
  	page_class = File.dirname( current_path ).gsub( '/', '-' )
    ( page_class == "index.html" ) ? "page-home" : "page-#{page_class}"
  end

end