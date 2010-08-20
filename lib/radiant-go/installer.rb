module RadiantGo

  class Installer
  
    def initialize(name, required_gems, force = false)    
      
      @project_name  = name
      @force         = force
      @required_gems = required_gems
      
    end
  
    def run
    
      if has_required_gems?(@required_gems)
        puts 'generating radiant project'
        generate_radiant_project(@project_name, @force)
        puts 'copying gemfile'
        copy_gemfile(@project_name)
        puts 'bundler is installing gems'
        bundle_install(@project_name)
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
      
      # todo: the below calls works fine, although it might be a bit nicer if the 
      # radiant gem can be invoked rather than having to run a system command
      if force
        %x[radiant #{name} --force --database=sqlite3]
      else
        %x[radiant #{name} --skip --database=sqlite3]
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
    
    def bundle_install(name)
      # todo: below currently doesn't work. Will need to use the module provided with the gem 'Bundler'
      puts %x["bundle install --gemfile #{name}/Gemfile"]
    end

  end

end