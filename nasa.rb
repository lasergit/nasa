#!/usr/bin/env ruby

require_relative 'rover'
require_relative 'universe.rb'

# NASA rover control API
class NasaApi
  attr_reader :pos
  def initialize(rover = Rover.new, plateaue)
    @rover = rover
    @plateau = Plateau.new(plateaue)
  end

  def landto(pos)
    setpos(pos) if @plateau.contains?(pos)
  end

  def setpos(pos)
    @rover.setpos(pos)
    @rover
  end

  def setcmd(cmds)
    @rover.cmds = cmds
    @rover
  end

  def exec
    @rover.exec
    @rover
  end
end
