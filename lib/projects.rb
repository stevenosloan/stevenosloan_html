require 'borrower'

class Projects < Middleman::Extension

  option :layout, false, 'Sets layout of projects'

  def initialize app, option_hash={}, &block
    super
    app.set :projects, projects
  end

  def projects
    @_projects ||= []
  end

  def manipulate_resource_list resources
    resources.map do |resource|
      if Project.is? resource.destination_path
        resource = Project.new(resource, options)
        projects << resource
      end
      resource
    end
  end

  class Project < Middleman::Sitemap::Resource

    class << self
      def is? path
        path.match(/^projects\//)
      end

      def renderer
        @@_renderer ||= Redcarpet::Markdown.new(
          ::Middleman::Renderers::MiddlemanRedcarpetHTML,
          :fenced_code_blocks => true,
          :autolink => true,
          :smartypants => true,
          :space_after_headers => true,
          :template_tag_headers => true
        )
      end
    end

    def initialize resource, options
      copy_instance_vars resource

      if options.layout
        @local_metadata.merge!({
          options: { layout: options.layout }
        })
      end
    end

    def readme
      raise "add a readme for '#{data.title}'" unless data.readme
      Project.renderer.render( Borrower.take( data.readme ).force_encoding('utf-8') )
    end

    def method_missing method_name
      data.send(method_name)
    end

    private

      def copy_instance_vars object
        vars = object.instance_variables.map(&:to_s)
        vars.each { |name| instance_variable_set(name, object.instance_variable_get(name)) }
      end

  end
end

::Middleman::Extensions.register(:projects, Projects)