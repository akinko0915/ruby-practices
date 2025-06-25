#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')

shots = scores.map { |s| s == 'X' ? [10, 0] : s.to_i }.flatten
frames = shots.each_slice(2).to_a

total = 0

frames.each_with_index do |frame, i|
  total += frame.sum
  next if frame.sum != 10 || i >= 9

  # ストライク
  if frame[0] == 10
    next_frame = frames[i + 1]
    total += if next_frame[0] == 10 && frames[i + 2]
               10 + frames[i + 2][0]
             else
               next_frame.sum
             end
  else
    # スペア
    total += frames[i + 1][0]
  end
end

puts total
