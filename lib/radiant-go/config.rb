module RadiantGo

  class Config
    
    class << self
      attr_accessor :database, :admin_name, :admin_user, :admin_pass, :database_template
    end
      
  end

end