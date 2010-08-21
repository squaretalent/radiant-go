require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Radiant do
      
      before(:all) do
        @installer = Radiant.new('test', Config.database, false)
      end
      
      after(:all) do
        FileUtils.rm_rf 'test'
      end
      
      it 'should create a new folder and files for a new project' do
        @installer.create
        File.directory?('test').should be true
      end

      it 'should not write over existing project files when force is off' do
        
        # make the README file blank (could be any radiant file instead of README)
        File.delete 'test/README'
        readme = File.new('test/README', File::CREAT)
        readme.close
        File.size('test/README').should be 0
        
        # it shouldn't override
        @installer.create
        File.size('test/README').should be 0
        
      end
      
      it 'should write over existing project files when force is on' do
        
        # turn force on
        @installer = Radiant.new('test', Config.database, true)
        
        # make the README blank (could be any radiant file instead of README)
        File.delete 'test/README'
        readme = File.new('test/README', File::CREAT)
        readme.close
        File.size('test/README').should be 0
        
        # it should ovveride
        @installer.create
        File.size('test/README').should be > 0
        
      end
      
      it 'should create a non empty database file upon bootstrap' do
        File.exists?('test/db/development.' + Config.database + '.db').should be false
        @installer.bootstrap
        File.exists?('test/db/development.' + Config.database + '.db').should be true
        File.size('test/db/development.' + Config.database + '.db').should be > 0
      end
      
      it 'should alter the configuration in the environment file' do
        # the size of the file should increase after it is altered
        size = File.size('test/config/environment.rb')
        @installer.update_config
        File.size('test/config/environment.rb').should_not be size
      end

    end
    
  end
  
end