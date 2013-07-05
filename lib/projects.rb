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

    def self.is? path
      path.match(/^projects\//)
    end

    def initialize resource, options
      copy_instance_vars resource

      if options.layout
        @local_metadata = @local_metadata.merge({
          options: { layout: options.layout }
        })
      end
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