require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Radiant do
      
      before(:all) do
        @main      = Main.new('test')
        @installer = Radiant.new('test', Config.database)
      end
      
      after(:all) do
        FileUtils.rm_rf 'test'
      end
      
      it 'should create a new folder and files for a new project' do
        @installer.create
        File.directory?('test').should be true
      end

      it 'should not write over existing project files' do
        
        # make the README file blank (could be any radiant file instead of README)
        File.delete 'test/README'
        readme = File.new('test/README', File::CREAT)
        readme.close
        File.size('test/README').should be 0
        
        # it shouldn't override
        @installer.create
        File.size('test/README').should be 0
        
      end
      
      it 'should create a non empty database file upon bootstrap' do
        
        File.exists?('test/db/development.' + Config.database + '.db').should be false
        @installer.bootstrap
        File.exists?('test/db/development.' + Config.database + '.db').should be true
        File.size('test/db/development.' + Config.database + '.db').should be > 0
        
      end
      
      it 'shouldnt bootstrap if a database file already exists' do
        File.exists?('test/db/development.' + Config.database + '.db').should be true
        File.size('test/db/development.' + Config.database + '.db').should be > 0
        
        # we remove our database
        File.delete('test/db/development.' + Config.database + '.db')
        
        # and replace it with a blank file
        database = File.new('test/db/development.' + Config.database + '.db', File::CREAT)
        database.close
        
        # bootstap shouldn't touch the db now!
        @installer.bootstrap
        File.size('test/db/development.' + Config.database + '.db').should be 0
        
        # cleanup (need a working DB for later tests)
        File.delete('test/db/development.' + Config.database + '.db')
        @installer.bootstrap
        
      end
      
      it 'should alter the configuration in the environment file' do
        
        # the size of the file should increase after it is altered
        size = File.size('test/config/environment.rb')
        @installer.update_config
        File.size('test/config/environment.rb').should_not be size
        
      end
      
      it 'should update all extensions' do
        
        # the contents of the public folder should change
        contents = %x[du test/public/]
        @installer.update_extensions
        %x[du test/public/].should_not be contents
        
      end
      
      it 'should migrate all extensions' do
        
        # migrating should cause the database to grow
        size = File.size('test/db/development.' + Config.database + '.db')
        @installer.migrate_extensions
        File.size('test/db/development.' + Config.database + '.db').should be > size
        
      end
      
      it 'should not create mutiple config.gem lines in the environment file' do
        @installer.update_config
        @installer.update_config
        
        required_gems = []
        environment   = File.open 'test/config/environment.rb' 
        
        while (line = environment.gets)
          if gem = line.match(/config.gem\s*['"](.*?)['"]/)
            required_gems <<  gem[1]
          end
        end
        
        required_gems.eql?(required_gems.uniq).should be true
      
      end

    end
    
  end
  
end