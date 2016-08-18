#!/usr/bin/env ruby

require 'pathname'
require 'optparse'
require_relative 'cmd'
require_relative 'nasa'
require_relative 'universe'

# Organizes Input
class Input
  attr_reader :current
  def initialize
    @default = <<DATA
5 5
1 2 N
LMLMLMLMM
3 3 E
MMRMMRMRRM
DATA
    @filename = Pathname.new('INPUT')
  end

  def dump
    File.write(@filename, @default)
    @current = @default
  end

  def finit
    File.exist?(@filename) && accept || dump
  end

  def accept
    @current = File.read(@filename)
  end
end

# Output responsible stuff
class Output
  def initialize(data)
    @data =  data
    @filename = Pathname.new('OUTPUT')
  end

  def create
    File.write(@filename, @data)
  end
end

# CLI interface
class Cli
  def initialize
    @borders = [5, 5]
    @start = [[1, 2, :N], [3, 3, :E]]
    @cmds = %w(LMLMLMLMM MMRMMRMRRM)
  end

  def parse
    OptionParser.new do |o|
      o.on('-h', '--help help', 'Helps you to control rovers squad.') do
        puts o
        exit
      end
    end.parse!
  end

  def main
    api = NasaApi.new(@borders)
    data = []
    @cmds.each_index do |i|
      c = Cmd.new(@cmds[i])
      data << api.landto(@start[i]).setcmd(c).exec.pos.join(' ')
    end
    Output.new(data.join("\n")).create
  end
end

Cli.new.main if __FILE__ == $PROGRAM_NAME
