module Go
  module Lib
    module Radiant
      module Setup
        
        def self.included(base)
          base.class_eval do
            private
            
            def create_records(template)
              records = template['records']
              if records
                puts
                records.keys.each do |key|
                  feedback "Creating #{key.to_s.underscore.humanize}" do
                    model = model(key)
                    model.reset_column_information
                    record_pairs = order_by_id(records[key])
                    step do
                      record_pairs.each do |id, record|
                        model.find(record.id).destroy
                        model.new(record).save
                      end
                    end
                  end
                end
              end
            end
          end
        end
        
      end
    end
  end
end