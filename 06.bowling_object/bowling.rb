#!/usr/bin/env ruby
# frozen_string_literal: true
require_relative './game'
raw_scores = ARGV[0].split(',')
game = Game.new(raw_scores)
puts game.total_score

