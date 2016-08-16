#!/usr/bin/env ruby

require "test/unit"

class String
      def valid
         return true
      end
end

class NasaApi

   def initialize(start)
      @pos = start
      @directions = { N:[0,1], S:[0,-1], W:[-1,0], E:[1,0] }
      @angles = { N:Math::PI/2, S:-Math::PI/2, W:Math::PI, E:0 }

      @rotations = { R:-Math::PI/2, L:Math::PI/2 }
      @inc = @directions[@pos[2]]

   end
   def setPos(pos)
      @pos = pos
      return self
   end
   def getPos
      return @pos
   end
   def SetCmdSeq(cmds)
      @cmds = cmds
      return self
   end

#    #@cmd.class
#
   def move
      # @cmds.each.respond_to?(:each_char)
      @cmds.each_char { |c|
            if @rotations.keys.include?(c.to_sym)
               rotate(@rotations[c.to_sym])
            end
            if c == "M"
               @pos[0]+= @inc[0]
               @pos[1]+= @inc[1]
            end
      } if @cmds.valid
      self
   end

   def rotate(c)
      angle = @angles[@pos[2]] + c
      @pos[2] = @directions.invert[[Math::cos(angle).round, Math::sin(angle).round]]
      @inc = @directions[@pos[2]]
      self
   end

end


class TestNasa < Test::Unit::TestCase

   def setup
      @start= [[1,2,:N], [3,3,:E]]
      @finish=[[1,3,:N],[5,1,:E]]
      @cmds = ["LMLMLMLMM", "MMRMMRMRRM"]
      @num = NasaApi.new(@start[0])
   end

   def test_getPos
      assert_equal @start, NasaApi.new(@start).getPos
   end
   def test_zero_move
      assert_equal @start[0], NasaApi.new(@start[0]).SetCmdSeq("").move.getPos()
      assert_equal @start[1], NasaApi.new(@start[1]).SetCmdSeq("").move.getPos()
   end

   def test_one_move
      assert_equal [1, 0, :E], NasaApi.new([0,0,:E]).SetCmdSeq("M").move.getPos()
   end

   def test_rotate
      assert_equal [1, 0, :E], NasaApi.new([1,0,:S]).rotate(Math::PI/2).getPos()
      assert_equal [1, 0, :E], NasaApi.new([1,0,:S]).SetCmdSeq("L").move.getPos()
   end

   def test_moves
       assert_equal @finish[0], NasaApi.new(@start[0]).SetCmdSeq(@cmds[0]).move.getPos()
       assert_equal @finish[1], NasaApi.new(@start[1]).SetCmdSeq(@cmds[1]).move.getPos()
   end

   def test_boundaries
       true
#       assert_raise( RuntimeError ) { SimpleNumber.new('a') }
   end


end 
