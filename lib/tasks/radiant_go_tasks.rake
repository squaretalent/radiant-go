namespace :db do
  desc "Bootstrap your database for Radiant."
  task :template => :environment do
    require 'radiant/setup'
    setup = Radiant::Setup.new
    setup.load_database_template(ENV['DATABASE_TEMPLATE'])
    setup.create_admin_user(ENV['ADMIN_NAME'], ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD'])
  end
end