class RadiantGoExtension < Radiant::Extension
  version "0.1"
  description "Radiant Go Extension"
  url "http://github.com/squaretalent/radiant-shop-extension"
  
  def activate    
    # Model Includes
    Radiant::Config.send :include, RadiantGo::Models::Radiant::Config
  end
  
end
