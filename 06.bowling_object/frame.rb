class Frame
  attr_reader :shots

  def initialize(shots)
    @shots = shots
  end

  def sum
    @shots.sum
  end

  def strike?
    @shots[0] == 10
  end

  def spare?
    @shots.sum == 10
  end

  def bonus_score(frame1, frame2)
    score = 0
    if strike?
      if frame1.strike? && frame2
        score = 10 + frame2.shots[0]
      else
        score = frame1.shots.sum
      end
    elsif spare?
      score = frame1.shots[0]
    end
    score
  end
end