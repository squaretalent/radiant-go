ActionController::Routing::Routes.draw do |map|
  
  map.with_options(:controller => 'admin/export') do |export|
    export.exporter 'admin/exporter.:format', :action => 'yaml'
  end
  
end