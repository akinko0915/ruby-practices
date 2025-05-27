#!/usr/bin/env ruby
# frozen_string_literal: true
score = ARGV[0]
scores = score.split(',')
shots = []
shots = scores.map { |score| score == 'X' ? [10, 0] : score.to_i }.flatten

frames = shots.each_slice(2).map{ |s| s }

total = 0
frames.each_with_index do |frame, frame_index|
  if frame_index < 9
    if frame[0] == 10
      if frames[frame_index + 1][0] == 10  # 次もストライク
        total += 10 + 10 + frames[frame_index + 2][0]
      else
        total += 10 + frames[frame_index + 1].sum
      end
    elsif frame.sum == 10 # スペア
      total += 10 + frames[frame_index + 1][0]
    else
      total += frame.sum # 通常
    end
  else
    total += frame.sum
  end
end

p total
