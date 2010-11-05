require 'rake'
require 'spec/rake/spectask'

begin
  
  require 'jeweler' # it's here and not up, if jeweler isn't installed, the rescue below will catch (end users don't need it)
  
  Jeweler::Tasks.new do |gem|
    gem.name = "radiant-go-extension"
    gem.summary = 'a quicker and easier way to setup radiant projects'
    gem.description = 'a quick an easy way to create radiant projects that are ready to use straight away, automatically perform bootstraps, migrations and updates for radiant and extensions, radiant-go is completely customizable little orphan awesome'
    gem.email = 'mario@mariovisic.com'
    gem.homepage = 'http://github.com/mariovisic/radiant-go-extension'
    gem.authors = ["Mario Visic", "Dirk Kelly"]
    gem.add_dependency('radiant', '>= 0.9.1')
    gem.add_dependency('bundler', '>= 0.9.26')
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. This is only required if you plan to package radiant-go as a gem."
end

desc 'run all specs'
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end