namespace :db do
  desc "Bootstrap your database for Radiant."
  task :template => :environment do
    require 'radiant/setup'
    Radiant::Setup.bootstrap(ENV['DATABASE_TEMPLATE'])
  end
end