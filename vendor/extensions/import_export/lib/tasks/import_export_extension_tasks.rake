require 'yaml_db'

namespace :db do
  desc "Import a database template from db/export.yml. Specify the TEMPLATE environment variable to load a different template. This is not intended for new installations, but restoration from previous exports."
  task :import do
    Rake::Task["db:schema:load"].invoke
    Rake::Task["db:data:load"].invoke
  end
  
  desc "Export a database template to db/data.yml"
  task :export do
    Rake::Task["db:schema:dump"].invoke
    Rake::Task["db:data:dump"].invoke
  end
end