#!/usr/bin/env ruby

# Comands validity check
class Cmd
  def initialize(cmd)
    @cmd = cmd.split('')
    @allowed = %w("L", "R", "M")
  end

  def each(&block)
    @cmd.each { |c| block.call(c) } if block_given?
  end

  def valid
    (@allowed && @cmd.uniq) == @cmd.uniq
  end
end
