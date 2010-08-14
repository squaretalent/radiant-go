#!/usr/bin/env ruby

require 'rubygems'
require 'radiant-go/installer.rb'


if ARGV.size == 0
  puts 'please specify a project name' 
else
  installer = RadiantGo::Installer.new(ARGV[0])
  installer.run()
end