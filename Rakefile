require 'rubygems'
require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'
require 'rake/gempackagetask'

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/*_spec.rb']
end

task :default => :spec

desc "Run rcov for code coverage"
task :rcov do
  sh 'rcov spec/*_spec.rb -x "spec/.*"'
end

desc "Generate documentation"
Rake::RDocTask.new("doc") { |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "Poisson Library Documentation"
  rdoc.options << '--line-numbers' << '--inline-source'
  %w(README LICENCE CHANGELOG lib/**/*.rb).each { |f| rdoc.rdoc_files.include f }
}

spec = Gem::Specification.new do |s|
  s.name = "poisson"
  s.version = "0.1"
  s.author = "Jonathan Leighton"
  s.email = "turnip@turnipspatch.com"
  s.homepage = "http://poisson.rubyforge.org/"
  s.summary = "A Ruby library for the Poisson distribution."
  s.files = FileList["{lib,spec}/**/*", "LICENCE", "README", "CHANGELOG"].to_a
  s.autorequire = "poisson"
  s.has_rdoc = true
  s.extra_rdoc_files =  %w(README LICENCE CHANGELOG)
end

Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_tar_gz = true
  pkg.need_zip = true
end

desc "Create the rubygem"
task :gem => "pkg/#{spec.name}-#{spec.version}.gem" do
  puts "Generated #{spec.name} version #{spec.version}"
end
