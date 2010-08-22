module RadiantGo
  
  module Installers

    class Main
  
      def initialize(name, force = false)    
      
        @project_name             = name
        @force                    = force
        Config.gemfile_location   = File.expand_path(File.dirname(__FILE__)) + '/../../../config/Gemfile'
      
      end
  
      def run
    
        radiant = Installers::Radiant.new(@project_name, Config.database, @force)
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

      def copy_gemfile(name)
      
        # we only copy the file if it doesn't exist or if force is on!
        if !File.exists?(name + '/Gemfile') || @force == true
          File.new(name + '/Gemfile', File::CREAT) unless File.exists?(name + '/Gemfile')

          source = File.open(Config.gemfile_location, 'r')
          target = File.open(name + '/Gemfile', 'w')

          target.write( source.read(64) ) while not source.eof?
          target.close
          source.close
        end

      end
      
      def self.all_extensions
        
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



