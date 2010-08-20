#!/usr/bin/env ruby

$LOAD_PATH.unshift File.dirname(__FILE__) + '/../lib'
require 'radiant-go'

if ARGV.size == 0
  puts 'please specify a project name' 
else
  
  force   = ARGV.any? {|arg| arg == '-f' || arg == '--force'}   ? true : false
  version = ARGV.any? {|arg| arg == '-v' || arg == '--version'} ? true : false
  name    = ARGV.shift

  if version == true
    puts RadiantGo::Main.version
  else
    installer = RadiantGo::Installers::Base.new(name, RadiantGo::Main.required_gems, force)
    installer.run()
  end
  
end