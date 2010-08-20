#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'radiant-go'

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
  
  installer = RadiantGo::Installer.new(name, RadiantGo::Main.required_gems, force)
  installer.run()
  
end