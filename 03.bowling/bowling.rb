#!/usr/bin/env ruby
# frozen_string_literal: true
require 'debug'

# 1.引数をとる
score = ARGV[0]

# 2. 1投毎に分割する
scores = score.split(',')

# 3. 数字に変換して配列に入れる
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
  else
    shots << s.to_i
  end
end

total = 0
frame = 0
i = 0

while frame < 10
  if shots[i] == 10
    total += 10
    total += shots[i + 1]
    total += shots[i + 2]
    i += 1
  elsif shots[i] + shots[i + 1] == 10
    total += 10
    total += shots[i + 2] #ペアの数字のもう一つ先の数字を足したいから+2
    i += 2
  else
    total += shots[i] + shots[i + 1]
    i += 2
  end
  frame += 1
end

p total
