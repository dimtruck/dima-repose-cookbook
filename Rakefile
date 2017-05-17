require 'rake'
require 'rspec/core/rake_task'
require 'bundler/setup'
require 'rubocop/rake_task'
require 'foodcritic'

desc 'Run RuboCop on the lib directory'
RuboCop::RakeTask.new(:rubocop) do |task|
  task.fail_on_error = true
  task.requires = ['rubocop/formatter/checkstyle_formatter']
  task.formatters = ['RuboCop::Formatter::CheckstyleFormatter']
  task.options = ['--out', 'int-lint-results.xml']
end

desc 'Foodcritic linter'
FoodCritic::Rake::LintTask.new(:foodcritic) do |t|
  t.options = {
    fail_tags: ['any']
  }
end

desc 'Run chefspec unit tests'
RSpec::Core::RakeTask.new(:unit) do |t|
  t.rspec_opts = [].tap do |a|
    a.push('--color')
    a.push('-r rspec_junit_formatter')
    a.push('--format RspecJunitFormatter')
    a.push('-o junit.xml')
  end.join(' ')
  t.pattern = 'test/unit/spec/*_spec.rb'
end

task default: %w[rubocop foodcritic unit]
