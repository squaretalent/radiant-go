module Go
  module Models
    module Radiant
      module Config
        
        def self.included(base)
          base.class_eval do
            def self.export(only=nil,except=nil)
              ignore = ['schema_migrations','extension_meta']
              armodels = (ActiveRecord::Base.connection.tables).reject{ |m| ignore.include?(m) }.map{ |m| m.pluralize.classify }
              
              if only && only.present?
                # Returns all models except those specified
                models = only.split(',').map { |m| m.pluralize.classify }
                models = armodels & models
              elsif except && except.present?
                # Returns only the specified models, unless they're not defined
                models = except.split(',').map { |m| m.pluralize.classify }
                models = armodels - models
              else
                models = armodels
              end
              
              klasses = models.map { |m| m.constantize }              
              
              records = {}
              klasses.each do |klass|
                records[klass.name.pluralize] = klass.find(:all).inject({}) { |h, record| h[record.id.to_i] = record.attributes; h }
              end
              
              description = { 'name' => 'name me', 'description' => 'optional' }
              description.to_yaml + { 'records' => records}.to_yaml
            end
          end
        end
        
      end
    end
  end
end