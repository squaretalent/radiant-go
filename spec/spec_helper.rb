current_directory = File.dirname(__FILE__) 
require 'spec/autorun'
require 'spec'
require current_directory + '/../lib/radiant-go.rb'

Dir[File.expand_path(File.join(File.dirname(__FILE__),'support','**','*.rb'))].each {|f| require f}

Spec::Runner.configure do |config|

end
