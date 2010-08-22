module RadiantGo
  
  module Installers
    
    class Radiant
         
      def initialize(name, database)
        @name     = name
        @database = database
      end
      
      def create
          %x[radiant #{@name} --skip --database=#{@database}]
      end
      
      def bootstrap
        # we only bootstrap if there's no database!
        if File.exists?(@name + '/db/development.' + Config.database + '.db') == false
          Dir.chdir(@name) do
            %x[rake db:bootstrap OVERWRITE=true ADMIN_NAME=#{Config.admin_name} ADMIN_USERNAME=#{Config.admin_user} ADMIN_PASSWORD=#{Config.admin_pass} DATABASE_TEMPLATE=#{Config.database_template}]
          end
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
          all_extensions.each do |gem|
            config_string += "  config.gem '#{gem[:name]}', :version => '#{gem[:requirement]}', :lib => false\n"
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
          all_extensions.each do |gem|
            # we need to use the short name for our migration, eg forms instead of radiant-forms-extension
            extension = gem[:name].scan(/^radiant-(.*)-extension$/)
            %x[rake radiant:extensions:#{extension}:migrate]
          end
        end
        
      end
      
      private
      
        def all_extensions
        
          extensions  = []
          gemfile     = File.open(Config.gemfile_location, 'r')

          while(line = gemfile.gets)
            if extension = line.match(/gem.*(radiant-.*-extension).*['"](.*)['"]/)
              extensions.push(:name => extension[1], :requirement => extension[2])
            end
            
          end    

          gemfile.close
          extensions
        
        end
      
    end
    
  end
  
end