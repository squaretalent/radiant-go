#!/usr/bin/env ruby

require 'rubygems'
require 'radiant-go'

current_dir = File.expand_path(File.dirname(__FILE__))

require current_dir + '/radiant-go/installers/base.rb'
require current_dir + '/radiant-go/installers/radiant.rb'

module RadiantGo

  class Main
    
    @required_gems =  
    [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
      { :name => 'bundler', :requirements => '>= 0.9.26'  } ]
    
    def self.version
      File.read(File.expand_path(File.dirname(__FILE__)) + '/../VERSION')
    end
    
    def self.required_gems
      @required_gems
    end

  end
  
end