require 'bundler'
require 'bundler/definition'

module RadiantGo
  
  module Installers
    
    class Radiant
         
      def initialize(name, database, force)
        @name     = name
        @database = database
        @force    = force
      end
      
      def create
        if @force
          %x[radiant #{@name} --force --database=#{@database}]
        else
          %x[radiant #{@name} --skip --database=#{@database}]
        end
      end
      
      def bootstrap
        Dir.chdir(@name) do
          %x[rake db:bootstrap OVERWRITE=true ADMIN_NAME=#{Config.radiant_admin_name} ADMIN_USERNAME=#{Config.radiant_admin_user} ADMIN_PASSWORD=#{Config.radiant_admin_pass} DATABASE_TEMPLATE=#{Config.radiant_database_template}]
        end
      end
      
      def update_config
        Dir.chdir(@name) do
        
          config  = File.open('config/environment.rb', 'r+')
          line    = ''
          
          while(line.index('config.gem') == nil)
            line = config.gets
          end
            
          config.write "\n"
        
          gems = ::Bundler::Definition.from_gemfile('Gemfile').dependencies
          
          gems.each do |gem|
            
            #todo: finish! Need to check for radiant extensions and add to environment.rb
            
          end
          
        end
        
      end
      
    end
    
  end
  
end