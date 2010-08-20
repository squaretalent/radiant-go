module RadiantGo
  
  module Installers
    
    class Bundler
         
      def initialize(name)
        @name = name
      end
      
      def run
        Dir.chdir(@name) do
          %x[bundle install]
        end
      end

    end
    
  end
  
end