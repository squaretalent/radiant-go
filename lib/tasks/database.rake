namespace :db do
  desc "Load Template into Radiant."
  task :bootstrap => :environment do
    require 'radiant/setup'
    Radiant::Setup.load_database_template(ENV['DATABASE_TEMPLATE'])
  end
end