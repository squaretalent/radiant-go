class GoExtension < Radiant::Extension
  version "0.1"
  description "Radiant Go Extension"
  url "http://github.com/squaretalent/radiant-shop-extension"
  
  def activate    
    # Model Includes
    Radiant::Config.send :include, Go::Models::Radiant::Config
    
    # Controller Includes
    Admin::ExportController.send :include, Go::Controllers::Admin::Export
  end
  
end
