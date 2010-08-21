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
        
          # open our config
          config_file   = File.open('config/environment.rb', 'r')
          config_string = ''
          line          = ''
          
          # read up to the part where we are loading gems
          while(line.index('config.gem') == nil)
            line          = config_file.gets
            config_string += line
          end
            
          # loop through all our radiant extensions and add the lines we need for config
          Main.all_extensions.each do |gem|
            config_string += "  config.gem '#{gem.name}', :version => '#{gem.requirement}', :lib => false\n"
          end
          
          # read the rest of the config 
          while(line = config_file.gets)
            config_string += line
          end
          
          # close the file, open it for reading and dump our string
          config_file.close
          config_file = File.open('config/environment.rb', 'w')
          
          config_file.write(config_string)
          config_file.close
          
        end
        
      end
      
      def update_extensions
        
        Dir.chdir(@name) do
          %x[rake radiant:extensions:update_all]
        end
        
      end
      
      def migrate_extensions
        
        Dir.chdir(@name) do
          Main.all_extensions.each do |gem|
            # we need to use the short name for our migration, eg forms instead of radiant-forms-extension
            extension = gem.name.scan(/^radiant-(.*)-extension$/)
            %x[rake radiant:extensions:#{extension}:migrate]
          end
        end
        
      end
      
    end
    
  end
  
end