#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  shots << (s == 'X' ? 10 : s.to_i)
end

total = 0
i = 0

(0...10).each do |frame|
  if shots[i] == 10
    total += 10 + shots[i + 1] + shots[i + 2]
    i += 1
  elsif shots[i] + shots[i + 1] == 10
    total += 10 + shots[i + 2]
    i += 2
  else
    total += shots[i] + shots[i + 1]
    i += 2
  end
  frame + 1
end

p total
