module RemoveDrafts

  # register the feature as an extension
  class << self

    def registered app
      app.after_configuration do
        sitemap.register_resource_list_manipulator(:remove_drafts, NoDraftSitemap.new(self))
      end
    end

    alias :included :registered
  end

  class NoDraftSitemap

    def initialize app
      @app = app
    end

    def manipulate_resource_list resources

      resources.map do |resource|
        if resource.metadata[:page]["draft"]
          resource.metadata[:page]["title"] << " - Draft" unless resource.metadata[:page]["title"].match( /\s-\sDraft$/ )

          if @app.build?
            resource = nil
          end
        end

        resource

      end.compact

    end

  end

end

::Middleman::Extensions.register(:remove_drafts, RemoveDrafts)