module Go
  module Models
    module Radiant
      module Config
        
        def self.included(base)
          base.class_eval do
            def self.export(only=nil,except=nil)
              klasses = find_klasses(only,except) 
              
              models  = constantize_klasses(klasses)
              
              records = retrieve_model_records(models)
              
              # Ensure order, name, description, records
              name = { 'name'        => 'name me' }.to_yaml
              desc = { 'description' => 'optional' }.to_yaml
              data = { 'records'     => records }.to_yaml
              
              name + desc + data
            end
            
            private
            
            def find_klasses(only,export)
              armodels = ['Radiant::Config']
              
              artables = (ActiveRecord::Base.connection.tables).map{ |m| m.pluralize.classify } # Compare apples and apples
              armodels += artables
              
              if only && only.present?
                # Returns all models specified
                models = only.split(',').map { |m| m.pluralize.classify }
                models = armodels & models
              elsif except && except.present?
                # Returns only the specified models, unless they're not defined
                models = except.split(',').map { |m| m.pluralize.classify }
                models = armodels - models
              else
                models = armodels
              end
              
              models
            end
            
            def constantize_klasses(models)
              klasses = []
              
              models.each do |klass|
                begin
                  klasses << klass.constantize
                rescue
                  # Well, that Class doesn't exist now, does it!
                end
              end
              
              klasses
            end
            
            def retrieve_records(klasses)
              records = {}
              
              klasses.each do |klass|
                begin
                  records[klass.name.pluralize] = klass.find(:all).inject({}) { |h, record| h[record.id.to_i] = record.attributes; h }
                rescue
                  # Guess that isn't an active record class afterall
                end
              end
              
              records
            end
            
          end
        end
        
      end
    end
  end
end