#!/usr/bin/env ruby

require 'rubygems'
require File.expand_path(File.dirname(__FILE__)) + '/radiant-go/installer.rb'


if ARGV.size == 0
  puts 'please specify a project name' 
else
  
  name  = ARGV.shift
  force = false
  
  ARGV.each do |arg|
    if arg == '--force'
      force = true 
    else
      raise "unknown argument #{arg}"
    end
  end
  
  installer = RadiantGo::Installer.new(name, force)
  installer.run()
  
end