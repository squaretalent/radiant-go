require 'yaml_db'

namespace :radiant do
  namespace :extensions do
    namespace :settings do
      
      desc "Runs the migration of the Settings extension"
      task :migrate => :environment do
        require 'radiant/extension_migrator'
        if ENV["VERSION"]
          SettingsExtension.migrator.migrate(ENV["VERSION"].to_i)
        else
          SettingsExtension.migrator.migrate
        end
      end
      
      desc "Copies public assets of the Settings to the instance public/ directory."
      task :update => :environment do
        is_svn_or_dir = proc {|path| path =~ /\.svn/ || File.directory?(path) }
        Dir[SettingsExtension.root + "/public/**/*"].reject(&is_svn_or_dir).each do |file|
          path = file.sub(SettingsExtension.root, '')
          directory = File.dirname(path)
          puts "Copying #{path}..."
          mkdir_p RAILS_ROOT + directory
          cp file, RAILS_ROOT + path
        end
      end

    end
  end
end

namespace :db do
  task :import do
    Rake::Task["db:schema:load"].invoke
    Rake::Task["db:data:load"].invoke
  end
  
  task :export do
    Rake::Task["db:schema:dump"].invoke
    Rake::Task["db:data:dump"].invoke
  end
end