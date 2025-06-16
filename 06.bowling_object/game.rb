require_relative './frame'
require_relative './shot'
class Game
  FRAME_COUNT = 10
  def initialize(raw_scores)
    shots = raw_scores.map { |s| Shot.new(s).score }
    @frames = build_frames(shots)
  end

  def build_frames(shots)
    frames = []
    count = 0
    (FRAME_COUNT - 1).times do
      if shots[count] == 10
        frames << Frame.new([10])
        count += 1
      else
        frames << Frame.new([shots[count], shots[count + 1]])
        count += 2
      end
    end
    frames << Frame.new(shots[count..])
    frames
  end

  def total_score
    @frames.each_with_index.sum do |frame, i|
      total = frame.sum
      if i < FRAME_COUNT - 1
        next_frame = @frames[i + 1]
        next_next_frame = @frames[i + 2]
        total += frame.bonus_score(next_frame, next_next_frame)
      end
      total
    end
  end
end
