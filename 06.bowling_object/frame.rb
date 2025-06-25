# frozen_string_literal: true

class Frame
  attr_reader :shots

  def initialize(shots)
    @shots = shots
  end

  def base_score
    @shots.sum
  end

  def strike?
    @shots[0] == 10
  end

  def spare?
    !strike? && (@shots.sum == 10)
  end

  def bonus_score(next_frame, next_next_frame = nil)
    return 0 unless strike? || spare?

    score = next_frame.shots[0]

    if strike?
      score += if next_frame.strike? && next_next_frame
                 next_next_frame.shots[0]
               else
                 next_frame.shots[1]
               end
    end

    score
  end
end
