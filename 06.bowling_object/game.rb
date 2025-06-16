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
      if i < 9
        total += bonus_score(frame, i)
      end
    end
    total
  end

  private

  def bonus_score(frame, index)
    next_frame = @frames[index + 1]
    score = 0
    if frame.strike?
      if next_frame.strike? && @frames[index + 2]
        score = 10 + @frames[index + 2].shots[0]
      else
        score = next_frame.shots.sum
      end
    elsif frame.spare?
      score = @frames[index + 1].shots[0]
    end
    score
  end
end