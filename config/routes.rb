ActionController::Routing::Routes.draw do |map|

  map.namespace :admin do |admin|
    admin.export 'export(.:format)', :controller => 'export', :action => 'yaml'
  end

end