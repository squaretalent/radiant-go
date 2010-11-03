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
      
      def migrate
        Dir.chdir(@name) do
          %x[rake db:migrate]
        end
      end
      
      def bootstrap
        Dir.chdir(@name) do
          template = File.expand_path("#{File.dirname(__FILE__)}/../../../db/templates/#{Config.database_template}")
          if File.exist?(template)
            # copy our template
            FileUtils.mkdir_p("db/templates")
            FileUtils.cp(template, "db/templates/#{Config.database_template}")
          end
          %x[rake db:bootstrap ADMIN_NAME=#{Config.admin_name} ADMIN_USERNAME=#{Config.admin_user} ADMIN_PASSWORD=#{Config.admin_pass} DATABASE_TEMPLATE=#{Config.database_template} --trace]
        end
      end
      
      def update_config
        
        Dir.chdir(@name) do
        
          # open our config
          config_file         = File.open 'config/environment.rb'
          current_gems        = []
          
          # get a list of the gems in the config
          while (line = config_file.gets)
            if gem = line.match(/config.gem\s*['"](.*?)['"]/)
              current_gems <<  gem[1]
            end
          end
          
          # go back to the beginning of our environment file and blank out our strings
          config_file.rewind
          line          = ''
          config_string = ''
          
          # read up to the part where we are loading gems
          while(line.index('config.gem') == nil)
            line          = config_file.gets
            config_string += line
          end
                
          # loop through all our radiant extensions and add the lines we need for config
          all_extensions.each do |gem|
            # we only add the gem to our config if it's not already there!
            if !current_gems.any? {|current_gem| current_gem == gem[:name]}
              config_string += "  config.gem '#{gem[:name]}', :version => '#{gem[:requirement]}', :lib => false\n"
            end
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
            if extension = line.match(/gem.*(radiant-.*-extension).*['"]\s*((=|>=|>|<|<=|~>)?\s*[\d.rc]*)\s*['"]/)
              extensions.push(:name => extension[1], :requirement => extension[2])
            end
            
          end    

          gemfile.close
          extensions
        
        end
      
    end
    
  end
  
end