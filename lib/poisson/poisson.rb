class Poisson
  
  attr_accessor :mean
  
  def initialize(mean)
    @mean = mean
  end
  
  def probability
    yield query = Query.new
    
    case query.condition
      when :==
        (Math.exp(-@mean) * mean**query.value) / Math.factorial(query.value)
      when :<=
        (0..query.value).inject(0) do |sum, value|
          sum += probability { |x| x == value }
        end
      when :>=
        1 - probability { |x| x < query.value }
      when :<
        probability { |x| x <= (query.value - 1) }
      when :>
        1 - probability { |x| x <= query.value }
    end
  end
  
  def + poisson
    self.class.new(@mean + poisson.mean)
  end
  
end
