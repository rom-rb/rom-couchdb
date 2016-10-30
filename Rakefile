require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

task default: [:test, :rubocop]

RuboCop::RakeTask.new

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/cases/*_test.rb']
  t.verbose = true
end
