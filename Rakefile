require 'rake'
require 'rake/rdoctask'
require 'spec/rake/spectask'

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
Rake::RDocTask.new("rdoc") { |rdoc|
  rdoc.rdoc_dir = 'doc'
  rdoc.title    = "Poisson Library Documentation"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('LICENCE')
  rdoc.rdoc_files.include('lib/**/*.rb')
}
