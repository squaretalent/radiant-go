require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Radiant do
      
      before(:each) do
        @installer = Radiant.new('test', Config.database, false)
      end
      
      after(:each) do
        FileUtils.rm_rf 'test'
      end
      
      it 'should create a new folder and files for a new project' do
        @installer.create
        File.directory?('test').should be true
      end
      
      
    end
    
  end
  
end