namespace :radiant do
  namespace :extensions do
    namespace :forms_mail do
      
      desc "Runs the migration of the Mail extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          FormsMailExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          FormsMailExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Custom Fields to the instance public/ directory."
      task :update => :environment do
        puts "nothing to do"
      end
      
    end
  end
end