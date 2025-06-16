require_relative './frame'
require_relative './shot'
class Game
  def initialize(raw_scores)
    shots = raw_scores.map { |s| Shot.new(s).score }.flatten
    @frames = shots.each_slice(2).map { |pair| Frame.new(pair) }
  end

  def total_score
    @frames.each_with_index.sum do |frame, i|
      total = frame.sum
      next_frame = @frames[i + 1]
      next_next_frame = @frames[i + 2]
      if (i < 9) && (frame.strike? || frame.spare?)
        total += frame.bonus_score(next_frame, next_next_frame)
      end
      total
    end
  end
end