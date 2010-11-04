namespace :db do
  desc "Bootstrap your database for Radiant."
  task :template => :environment do
    require 'radiant/setup'
    setup = Radiant::Setup.new
    setup.load_database_template(ENV['DATABASE_TEMPLATE'])
  end
end