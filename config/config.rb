module RadiantGo

  Config.database = 'sqlite3'
  Config.required_gems = 
  [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
    { :name => 'bundler', :requirements => '>= 0.9.26'  } ]

end