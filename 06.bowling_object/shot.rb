# frozen_string_literal: true

class Shot
  attr_reader :score

  def initialize(raw_score)
    @score = raw_score == 'X' ? 10 : raw_score.to_i
  end
end
