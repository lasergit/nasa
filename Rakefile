#!/usr/bin/env ruby

require 'rake/testtask'

Rake::TestTask.new do |t|
  t.name = 'test'
  t.libs << 'test'
  t.test_files = FileList["test_nasa.rb"]
  t.warning = false
  t.verbose = false
end
