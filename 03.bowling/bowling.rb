#!/usr/bin/env ruby
# frozen_string_literal: true
require 'debug'

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

# スペア・ストライクフラグを作る
is_spare = false
is_strike = false

# ボーナスポイントを格納する配列を作る
bonus_points = []
total = 0
frames.each do |f|
  if is_spare
    bonus_points.push(f[0]);
    is_spare = false
  end
  if is_strike
    bonus_points.push(f[0]);
    if f[1]
    bonus_points.push(f[1]);
    end
    is_strike = false
  end

  total += f.sum

  if (f.sum == 10 && f[0] != 10) || (f[0] == 0 && f[1] == 10)
    is_spare = true
  end

  if f[0] == 10
    is_strike = true
  end
end
score = total + bonus_points.sum
p score
