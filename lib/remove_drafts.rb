class RemoveDrafts < Middleman::Extension
  def initialize app, options={}, &block
    super
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

::Middleman::Extensions.register(:remove_drafts, RemoveDrafts)