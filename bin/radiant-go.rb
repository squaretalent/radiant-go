#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'radiant-go'

if ARGV.size == 0
  puts 'please specify a project name' 
else
  
  name    = ARGV.shift unless ARGV[0] == '-v' || ARGV[0] == '--version'
  force   = false
  version = false
  
  ARGV.each do |arg|
    if arg == '--force'
      force = true
    elsif arg == '-v' || arg == '--version'
      version = true
    else
      raise "unknown argument #{arg}"
    end
  end
  
  if version == true
    puts RadiantGo::Main.version
  else
    installer = RadiantGo::Installer.new(name, RadiantGo::Main.required_gems, force)
    installer.run()
  end
  
end