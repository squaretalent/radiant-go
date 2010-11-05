module Go
  module Controllers
    module Admin
      module Export
        
        def self.included(base)
          base.class_eval do
            def yaml
              hash = Radiant::Config.export(params[:only], params[:except])
              
              render :text => hash, :content_type => "text/yaml"
            end
          end
        end
        
      end
    end
  end
end