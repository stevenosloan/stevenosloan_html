module CustomHelpers

  def versioned_script( script_name )
    tag = javascript_include_tag "#{script_name}"
    tag.gsub('<script src="', '' ).gsub('" type="text/javascript"></script>', '' )
  end

  def render_partial( partial_name )
    partial "partials/#{partial_name}"
  end

end