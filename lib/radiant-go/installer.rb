module RadiantGo

  class Installer
  
    def initialize(name)    
    
      @project_name = name
      @required_gems =  
      [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
        { :name => 'bundler', :requirements => '>= 0.9.26'  } ]
      
    end
  
    def run
    
      if has_required_gems?(@required_gems)
        generate_radiant_project(@project_name)
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

  
    def generate_radiant_project(name)
      %x[radiant #{name}]
    end

  end

end