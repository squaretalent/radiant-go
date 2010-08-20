module RadiantGo
  
  module Installers
    
    class Bundler
         
      def initialize(name)
        @name = name
      end
      
      def install
        Dir.chdir(@name) do
          %x[bundle lock;bundle install;bundle unlock]
        end
      end

    end
    
  end
  
end