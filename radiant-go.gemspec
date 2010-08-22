# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{radiant-go}
  s.version = "0.1.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["mariovisic"]
  s.date = %q{2010-08-23}
  s.default_executable = %q{radiant-go}
  s.description = %q{a quick an easy way to create radiant projects that are ready to use straight away, automatically perform bootstraps, migrations and updates for radiant and extensions, radiant-go is completely customizable little orphan awesome}
  s.email = %q{mario@mariovisic.com}
  s.executables = ["radiant-go"]
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    ".gitignore",
     "CHANGELOG",
     "README.rdoc",
     "Rakefile",
     "USAGE",
     "VERSION",
     "bin/radiant-go",
     "config/Gemfile",
     "config/config.rb",
     "lib/radiant-go.rb",
     "lib/radiant-go/config.rb",
     "lib/radiant-go/installers/bundler.rb",
     "lib/radiant-go/installers/main.rb",
     "lib/radiant-go/installers/radiant.rb",
     "radiant-go.gemspec",
     "spec/radiant-go/installers/bundler_spec.rb",
     "spec/radiant-go/installers/main_spec.rb",
     "spec/radiant-go/installers/radiant_spec.rb",
     "spec/rcov.opts",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/squaretalent/radiant-go}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{a quicker and easier way to setup radiant projects}
  s.test_files = [
    "spec/radiant-go/installers/bundler_spec.rb",
     "spec/radiant-go/installers/main_spec.rb",
     "spec/radiant-go/installers/radiant_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<radiant>, [">= 0.9.1"])
      s.add_runtime_dependency(%q<bundler>, [">= 0.9.26"])
    else
      s.add_dependency(%q<radiant>, [">= 0.9.1"])
      s.add_dependency(%q<bundler>, [">= 0.9.26"])
    end
  else
    s.add_dependency(%q<radiant>, [">= 0.9.1"])
    s.add_dependency(%q<bundler>, [">= 0.9.26"])
  end
end

