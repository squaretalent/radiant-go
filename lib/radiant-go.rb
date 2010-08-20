#!/usr/bin/env ruby

require 'rubygems'
require 'bundler'

current_dir = File.expand_path(File.dirname(__FILE__))

require current_dir + '/radiant-go/config.rb'
require current_dir + '/../config/config.rb'
require current_dir + '/radiant-go/installers/main.rb'
require current_dir + '/radiant-go/installers/radiant.rb'
require current_dir + '/radiant-go/installers/bundler.rb'

module RadiantGo

  class Main
  
    def self.version
      File.read(File.expand_path(File.dirname(__FILE__)) + '/../VERSION')
    end

  end
  
end