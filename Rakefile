require 'rake'
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
