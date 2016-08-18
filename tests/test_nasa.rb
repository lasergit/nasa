#!/usr/bin/env ruby

require 'test/unit'
require_relative '../nasa'

# NasaApi unit-testing
class TestNasa < Test::Unit::TestCase
  def setup
    @start = [[1, 2, :N], [3, 3, :E]]
    @finish = [[1, 3, :N], [5, 1, :E]]
    @cmds = %w(LMLMLMLMM MMRMMRMRRM)
    @api = NasaApi.new([5, 5])
  end

  def test_rotate
    c = Cmd.new('L')
    assert_equal [1, 0, :E], @api.landto([1, 0, :S]).setcmd(c).exec.pos
  end

  def test_rover0
    c = Cmd.new(@cmds[0])
    assert_equal @finish[0], @api.landto(@start[0]).setcmd(c).exec.pos
  end

  def test_rover1
    c = Cmd.new(@cmds[1])
    assert_equal @finish[1], @api.landto(@start[1]).setcmd(c).exec.pos
  end
end
