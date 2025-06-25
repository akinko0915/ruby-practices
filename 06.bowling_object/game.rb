# frozen_string_literal: true

require_relative './frame'
require_relative './shot'
class Game
  FRAME_COUNT = 10
  def initialize(raw_scores)
    shots = raw_scores.map { |s| Shot.new(s) }
    @frames = build_frames(shots)
  end

  def build_frames(shots)
    shot_scores = shots.map{ |shot| shot.score }
    frames = []
    count = 0
    (FRAME_COUNT - 1).times do
      if shot_scores[count] == 10
        frames << Frame.new([10])
        count += 1
      else
        frames << Frame.new([shot_scores[count], shot_scores[count + 1]])
        count += 2
      end
    end
    frames << Frame.new(shot_scores[count..])
    frames
  end

  def total_score
    @frames.each_with_index.sum do |frame, i|
      total = frame.base_score
      if i < FRAME_COUNT - 1
        total += frame.bonus_score(*@frames[(i + 1)..(i + 2)])
      end
      total
    end
  end
end
