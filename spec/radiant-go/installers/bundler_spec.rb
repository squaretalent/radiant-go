require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Bundler do
      
      before(:all) do
        @bundler    = Bundler.new('test')
        @installer  = Main.new('test')
        Dir.mkdir 'test'
        
      end
      
      after(:all) do
        FileUtils.rm_rf 'test'
      end
      
      it 'should install all required gems with bundle install' do
        
        # we shouldn't have a .bundle folder
        File.directory?('test/.bundle').should be false
        @installer.copy_gemfile
        @bundler.install
        
        # after running bundler we should have our .bundle directory
        File.directory?('test/.bundle').should be true
      
      end
   
    end
    
  end
  
end