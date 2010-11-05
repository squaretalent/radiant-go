require 'radiant/setup'
require 'fileutils'

namespace :db do
  desc "Bootstrap your database for Radiant."
  task :load => :environment do
    setup = Radiant::Setup.new
    setup.load_database_template(ENV['TEMPLATE'])
    setup.create_admin_user(ENV['ADMIN_NAME'], ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD'])
  end
  
  desc "Export specific models to yaml"
  task :export => :environment do
    file = ENV['FILE'] || 'data.yml'
    
    hash = { 'records' => Radiant::Config.export(ENV['ONLY'], ENV['EXCEPT']) }
    
    mkdir_p("#{RAILS_ROOT}/db/templates/", :verbose => false)
    target = File.new("#{RAILS_ROOT}/db/templates/#{file}", "w")
    target.write(hash)
    target.close
  end
end