require_relative './frame'
require_relative './shot'

class Game
  def initialize(raw_scores)
    shots = raw_scores.map { |s| Shot.new(s).score }.flatten
    @frames = shots.each_slice(2).map { |pair| Frame.new(pair) }
  end

  def total_score
    total = 0
    @frames.each_with_index do |frame, i|
      total += frame.sum
      next if frame.sum != 10 || i >= 9

      total += bonus_score(frame, i)
    end

    total
  end

  private

  def bonus_score(frame, index)
    if frame.strike?
      next_frame = @frames[index + 1]
      if next_frame.strike? && @frames[index + 2]
        10 + @frames[index + 2].shots[0]
      else
        next_frame.shots.sum
      end
    else
      @frames[index + 1].shots[0]
    end
  end
end