module RadiantGo

  class Config
    
    class << self
      attr_accessor :database, :required_gems, :radiant_admin_name, :radiant_admin_user, :radiant_admin_pass, :radiant_database_template
    end
      
  end

end