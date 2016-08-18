#!/usr/bin/env ruby

require 'test/unit'

# Model of the Mars terrain.
class Plateau
  def initialize(e)
    @begin = [0, 0]
    @end = e
  end

  def contains?(pos)
    pos[0..1].each_index { |i| pos[i].between?(@begin[i], @end[i]) }.all?
  end
end
