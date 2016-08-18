#!/usr/bin/env ruby

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = 'test'
  t.libs << 'test'
  t.test_files = FileList['tests/test_nasa.rb', 'tests/test_rover.rb']
  t.warning = false
  t.verbose = false
end
