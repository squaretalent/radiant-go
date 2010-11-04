namespace :db do
  desc "Load Template into Radiant."
  task :load_template => :environment do
    require 'radiant/setup'
    Radiant::Setup.load_database_template(ENV['DATABASE_TEMPLATE'])
  end
end