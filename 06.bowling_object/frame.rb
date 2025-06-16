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
end