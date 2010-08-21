module RadiantGo
  
  module Installers

    class Main
  
      def initialize(name, force = false)    
      
        @project_name  = name
        @force         = force
        @database      = Config.database
      
      end
  
      def run
    
        radiant = Installers::Radiant.new(@project_name, @database, @force)
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

          source = File.open(File.expand_path(File.dirname(__FILE__)) + '/../Gemfile')
          target = File.open(name + '/Gemfile', 'w')

          target.write( source.read(64) ) while not source.eof?
          target.close
          source.close
        end

      end
      
      def self.all_extensions
        
        extensions = []
        gems       = ::Bundler::Definition.from_gemfile('Gemfile').dependencies

        gems.each do |gem|
          
          # we only want radiant extensions
          if gem.name =~ /^radiant-.*-extension$/
            extensions.push(gem)
          end
          
        end
        extensions
      end

    end
    
  end

end