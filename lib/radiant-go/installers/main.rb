module RadiantGo
  
  module Installers

    class Main
  
      def initialize(name)    
      
        @project_name = name
                
        if File.exists? @project_name + '/config/radiant-go.rb'
          require @project_name + '/config/radiant-go.rb'
        end
        
        # setup default gemfile location
        if File.exists?(@project_name + '/Gemfile')
          Config.gemfile_location = @project_name + '/Gemfile'
        else
          Config.gemfile_location = File.expand_path(File.dirname(__FILE__)) + '/../../../config/Gemfile' 
        end
      
      end
  
      def run
    
        radiant = Installers::Radiant.new(@project_name, Config.database)
        bundler = Installers::Bundler.new(@project_name)
        
        puts '== generating radiant project'
        radiant.create
        puts '== copying gemfile'
        copy_gemfile(@project_name)
        puts '== bundler is installing gems'
        bundler.install
        puts '== running bootstrap'
        radiant.bootstrap
        puts '== updating config'
        radiant.update_config
        puts '== updating extensions'
        radiant.update_extensions
        puts '== migrating extensions'
        radiant.migrate_extensions
          
      end

      def copy_gemfile
      
        # we only copy the file if it doesn't exist
        if !File.exists?(@project_name + '/Gemfile')
          File.new(@project_name + '/Gemfile', File::CREAT) unless File.exists?(@project_name + '/Gemfile')

          source = File.open(Config.gemfile_location, 'r')
          target = File.open(@project_name + '/Gemfile', 'w')

          target.write( source.read(64) ) while not source.eof?
          target.close
          source.close
        end

      end
      
      def generate_config
        
       if !File.exists? @project_name
         # create our directory if there isn't one
         Dir.mkdir @project_name
       end
       
       if !File.exists? @project_name + '/config'
         # create our config directory if it doesn't already exist!
         Dir.mkdir @project_name + '/config'
       end
         
       # copy our gemfile
       source = File.open(File.expand_path(File.dirname(__FILE__)) + '/../../../config/Gemfile')
       target = File.open(@project_name + '/Gemfile', 'w')  
       target.write( source.read(64) ) while not source.eof?
       target.close
       source.close
       
       # copy our config file
       source = File.open(File.expand_path(File.dirname(__FILE__)) + '/../../../config/config.rb')
       target = File.open(@project_name + '/config/radiant-go.rb', 'w')  
       target.write( source.read(64) ) while not source.eof?
       target.close
       source.close
         
      end

    end
    
  end

end



