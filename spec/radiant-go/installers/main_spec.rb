require File.dirname(__FILE__) + '/../../spec_helper'

module RadiantGo

  module Installers
    
    describe Main do
      
      it 'should be able to return an array of extensions required' do
        Main.all_extensions.kind_of?(Array).should be true
      end
      
      it 'should list at least one extension' do
        Main.all_extensions.size.should be > 0
      end
      
    end

    describe Main, 'with forcing turned off' do
    
      before(:each) do
        Dir.mkdir 'test'
        @main = Main.new('test', false)
      end
      
      after(:each) do
        FileUtils.rm_rf 'test'
      end
  
      it 'should create a copy of the gemfile' do
        @main.copy_gemfile('test')
        File.exists?('test/Gemfile').should be true
      end
      
      it 'should have a gemfile that isn\'t empty' do
        @main = Main.new('test', false)
        @main.copy_gemfile('test')
        File.zero?('test/Gemfile').should_not be true
      end
      
      it 'should not write over an existing gemfile' do
        
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
    
    describe Main, 'with forcing turned on' do

      before(:each) do
        Dir.mkdir 'test'
        @main = Main.new('test', true)
      end

      after(:each) do
        FileUtils.rm_rf 'test'
      end

      it 'should write over an existing gemfile' do
        
        # we create a new gemfile and make it blank
        gemfile = File.new('test/Gemfile', File::CREAT)
        gemfile.close
        File.size('test/Gemfile').should be 0
        
        # we copy the file over our gemfile, now it should have a different filesize
        @main.copy_gemfile('test')
        File.exists?('test/Gemfile').should be true
        File.size('test/Gemfile').should be > 0
      end
        
    end

  end

end