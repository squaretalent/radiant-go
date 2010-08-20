#!/usr/bin/env ruby

require 'lib/radiant-go'

if ARGV.size == 0
  puts 'please specify a project name' 
else
  
  force   = ARGV.any? {|arg| arg == '-f' || arg == '--force'}   ? true : false
  version = ARGV.any? {|arg| arg == '-v' || arg == '--version'} ? true : false
  name    = ARGV.shift

  if version == true
    puts RadiantGo::Main.version
  else
    installer = RadiantGo::Installers::Main.new(name, force)
    installer.run()
  end
  
end