class Shot
  attr_reader :score

  def initialize(raw_score)
    @score = raw_score == 'X' ? [10, 0] : raw_score.to_i
  end
end