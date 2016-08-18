#!/usr/bin/env ruby

require_relative 'cmd'

# rover model
class Rover
  attr_accessor :pos
  attr_accessor :cmds
  attr_reader :inc
  def initialize(start = nil)
    @pos = start
    @directions = { N: [0, 1], S: [0, -1], W: [-1, 0], E: [1, 0] }
    @angles = { N: Math::PI / 2, S: -Math::PI / 2, W: Math::PI, E: 0 }

    @rotations = { R: -Math::PI / 2, L: Math::PI / 2 }
  end

  private

  def move
    @pos[0..1].each_index { |i| @pos[i] += @inc[i] }
  end

  def rotate(c)
    angle = @angles[@pos[2]] + c
    @pos[2] = @directions.invert[[Math.cos(angle).round, Math.sin(angle).round]]
    @inc = @directions[@pos[2]]
    self
  end

  public

  def setpos(pos)
    @pos = pos
    @inc = @directions[@pos[2]]
    self
  end

  def setcmd(cmds)
    @cmds = cmds
    self
  end

  def exec
    @cmds.each do |c|
      rotate(@rotations[c.to_sym]) if @rotations.keys.include?(c.to_sym)
      move if c == 'M'
    end if @cmds.valid
    self
  end
end
