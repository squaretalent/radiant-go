module RadiantGo
  
  module Installers

    class Base
  
      def initialize(name, force = false)    
      
        @project_name  = name
        @force         = force
        @database      = Config.database
        @required_gems = Config.required_gems
      
      end
  
      def run
    
        if has_required_gems?(@required_gems)
          
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
          
        end
    
      end
  
      def has_required_gems?(gems)
    
        valid = true
    
        gems.each do |gem|
          unless Gem.available?(gem[:name], gem[:requirements])
            puts "the gem #{gem[:name]} v#{gem[:requirements]} is required. please install it and run radiant-go again"
            valid = false
          end
        end
    
        valid
    
      end

      def copy_gemfile(name)
      
        # we only copy the file if it doesn't exist or if force is on!
        if !File.exists?(name + '/Gemfile') || @force == true
          File.new(name + '/Gemfile', File::CREAT) unless File.exists?(name + '/Gemfile')

          source = File.open(File.expand_path(File.dirname(__FILE__)) + '/../Gemfile')
          target = File.open(name + '/Gemfile', 'w')

          target.write( source.read(64) ) while not source.eof?
          target.close
        end

      end

    end
    
  end

end