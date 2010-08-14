module RadiantGo

  class Installer
  
    def initialize(name, force = false)    
      
      @project_name  = name
      @force         = force
      @required_gems =  
      [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
        { :name => 'bundler', :requirements => '>= 0.9.26'  } ]
      
    end
  
    def run
    
      if has_required_gems?(@required_gems)
        puts 'generating radiant project'
        generate_radiant_project(@project_name, @force)
        puts 'copying gemfile'
        copy_gemfile(@project_name)
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

  
    def generate_radiant_project(name, force)
      if force
        %x[radiant #{name} --force]
      else
        %x[radiant #{name} --skip]
      end
    end
    
    def copy_gemfile(name)
      
      # we only copy the file if it doesn't exist or if force is on!
      if !File.exists?(name + '/Gemfile') || @force == true
        File.new(name + '/Gemfile', File::CREAT) unless File.exists?(name + '/Gemfile')

        source = File.open(File.expand_path(File.dirname(__FILE__)) + '/Gemfile')
        target = File.open(name + '/Gemfile', 'w')

        target.write( source.read(64) ) while not source.eof?
      end

    end

  end

end