ActionController::Routing::Routes.draw do |map|
  
  map.with_options(:controller => 'admin/export') do |export|
    export.export 'admin/exporter(.:format)', :action => 'yaml'
  end
  
end