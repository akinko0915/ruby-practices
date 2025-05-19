#!/usr/bin/env ruby
# 1.引数をとる
score = ARGV[0]
# 2. 1投毎に分割する
scores = score.split(',')
# 3. 数字に変換
frames = scores.map{ |score| score.to_i }
# 4. フレーム毎に分割
p frames.each_slice(2).to_a
