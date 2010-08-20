module RadiantGo
  
  module Installers
    
    class Radiant
         
      def initialize(name, database, force)
        @name     = name
        @database = database
        @force    = force
      end
      
      def create
        if @force
          %x[radiant #{@name} --force --database=#{@database}]
        else
          %x[radiant #{@name} --skip --database=#{@database}]
        end
      end
      
      def update
        #todo: finish
      end
      
    end
    
  end
  
end