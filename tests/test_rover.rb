#!/usr/bin/env ruby

require 'test/unit'
require_relative '../rover'

# Ensures rover is cotrolled
class TestRover < Test::Unit::TestCase
  def setup
    @start = [1, 2, :N]
    @rover = Rover.new
  end

  def test_setpos
    assert_equal Rover, @rover.setpos([]).class
    assert_equal nil, @rover.setpos([]).inc
    assert_equal @start, @rover.setpos(@start).pos
    assert_equal [0, 1], @rover.inc
  end

  def test_set_cmd
    c = Cmd.new('')
    assert_equal Rover, @rover.setcmd(c).class
  end

  def test_zero_move1
    c = Cmd.new('')
    assert_equal @start, @rover.setpos(@start).setcmd(c).exec.pos
  end

  def test_one_move
    c = Cmd.new('M')
    assert_equal [1, 0, :E], @rover.setpos([0, 0, :E]).setcmd(c).exec.pos
  end

  def test_rotate
    pos = @rover.setpos([1, 0, :S]).send(:rotate, Math::PI / 2).pos
    assert_equal [1, 0, :E], pos
  end
end
