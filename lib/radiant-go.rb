#!/usr/bin/env ruby

require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/radiant-go/installer.rb'

module RadiantGo

  class Main
    
    # Set the release version below
    
    @major = '0'
    @minor = '1'
    @tiny  = '0'
    @patch = nil # set to nil for normal release
    
    @required_gems =  
    [ { :name => 'radiant', :requirements => '>= 0.9.1'   },
      { :name => 'bundler', :requirements => '>= 0.9.26'  } ]
    
    def self.version
      [@major, @minor, @tiny, @patch].delete_if{|v| v.nil? }.join('.')
    end
    
    def self.required_gems
      @required_gems
    end

  end
  
end