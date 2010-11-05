require 'radiant/setup'
require 'fileutils'

namespace :db do
  desc "Bootstrap your database for Radiant."
  task :load => :environment do
    setup = Radiant::Setup.new
    setup.load_database_template(ENV['TEMPLATE'])
    if ENV['ADMIN_NAME'].present?
      setup.create_admin_user(ENV['ADMIN_NAME'], ENV['ADMIN_USERNAME'], ENV['ADMIN_PASSWORD'])
    end
  end
  
  desc "Export specific models to yaml"
  task :export => :environment do
    armodels = (ActiveRecord::Base.send(:subclasses) - Page.send(:subclasses)).map { |m| m.name }
    file = ENV['FILE'] || 'data.yml'
    
    if ENV['ONLY'].present?
      # Returns only the specified models, unless they're not defined
      models = ENV['ONLY'].split(',').map { |m| m.pluralize.classify }
      models = armodels & models
    elsif ENV['EXCEPT'].present?
      # Returns all models except those specified
      models = ENV['EXCEPT'].split(',').map { |m| m.pluralize.classify }
      models = armodels - models
    else
      models = armodels
    end
    
    hash = { 'records' => {} }
    models.uniq.each do |model|
      model = model.constantize
      hash['records'][model.name.pluralize] = model.find(:all).inject({}) { |h, record| h[record.id.to_i] = record.attributes; h }
      hash.reject!{|k,v| !v.present?}
    end
    
    mkdir_p("#{RAILS_ROOT}/db/templates/", :verbose => false)
    target = File.new("#{RAILS_ROOT}/db/templates/#{file}", "w")
    target.write(hash.to_yaml)
    target.close
  end
end