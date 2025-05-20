#!/usr/bin/env ruby
# frozen_string_literal: true

# 1.引数をとる
score = ARGV[0]
# 2. 1投毎に分割する
scores = score.split(',')
# 3. 数字に変換
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end
# 4. フレーム毎に分割
frames = shots.each_slice(2).to_a

# 5. 単純に合計値を計算する
total = 0
frames.each do |f|
  total += f.sum
end
p total
