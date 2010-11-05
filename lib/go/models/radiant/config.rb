module Go
  module Models
    module Radiant
      module Config
        
        def self.included(base)
          base.class_eval do
            def self.export(only=nil, except=nil)
              armodels = (ActiveRecord::Base.send(:subclasses) - Page.send(:subclasses)).map { |m| m.name }
              
              if except && except.present?
                # Returns only the specified models, unless they're not defined
                models = except.split(',').map { |m| m.pluralize.classify }
                models = armodels & models
              elsif only && only.present?
                # Returns all models except those specified
                models = only.split(',').map { |m| m.pluralize.classify }
                models = armodels - models
              else
                models = armodels
              end
              
              models = models.map { |m| m.constantize }              
              
              hash = {}
              klasses.each do |klass|
                hash[klass.name.pluralize] = klass.find(:all).inject({}) { |h, record| h[record.id.to_i] = record.attributes; h }
              end
              hash.to_yaml
            end
          end
        end
        
      end
    end
  end
end