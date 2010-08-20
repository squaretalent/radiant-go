module RadiantGo

  Config.database = 'sqlite3'
  Config.required_gems = 
  [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
    { :name => 'bundler', :requirements => '>= 0.9.26'  } ]
    
  Config.radiant_admin_name         = 'Administrator'
  Config.radiant_admin_user         = 'admin'
  Config.radiant_admin_pass         = 'radiant'
  Config.radiant_database_template  = 'empty.yml'
  
  # available database templates are empty.yml, roasters.yml, simple-blog.yml, styled-blog.yml

end