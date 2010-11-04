namespace :db do
  desc "Bootstrap your database for Radiant."
  task :template do
    require 'radiant/setup'
    Radiant::Setup.load_database_template(ENV['DATABASE_TEMPLATE'])
  end
end