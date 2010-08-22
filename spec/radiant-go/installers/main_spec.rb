require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Main do
      
      before(:each) do
        Dir.mkdir 'test'
        @main = Main.new('test')
      end
      
      after(:each) do
        FileUtils.rm_rf 'test'
      end
      
      it 'should be able to return an array of extensions required' do
        Main.all_extensions.kind_of?(Array).should be true
      end
      
      it 'should list at least one extension' do
        Main.all_extensions.size.should be > 0
      end
      
      it 'should create a copy of the gemfile' do
        @main.copy_gemfile('test')
        File.exists?('test/Gemfile').should be true
      end
      
      it 'should have a gemfile that isn\'t empty' do
        @main.copy_gemfile('test')
        File.zero?('test/Gemfile').should_not be true
      end
      
      it 'should not write over an existing gemfile when force is off' do
        
        # we create a new gemfile and make it blank
        gemfile = File.new('test/Gemfile', File::CREAT)
        gemfile.close
        File.size('test/Gemfile').should be 0
        
        # we run the copy gemfile method, it shouldn't work as the file already exists
        @main.copy_gemfile('test')
        File.exists?('test/Gemfile').should be true
        File.size('test/Gemfile').should be 0
      end
            
    end

  end

end