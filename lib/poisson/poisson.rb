class Poisson
  
  class InvalidMean < Exception; end;
  
  attr_accessor :mean
  
  # Instantiate a new Poisson instance, passing the mean number of occurrence of the event.
  def initialize(mean)
    if !mean.is_a?(Numeric)
      raise InvalidMean, "the mean must be numeric"
    elsif mean < 0
      raise InvalidMean, "the mean must be positive"
    end
    
    @mean = mean
  end
  
  # Calculate the probability of a "query" happening. This method passes a
  # Poisson::Query instance to the block. You place conditions on the Query
  # within the block and the probability is returned. Example:
  #
  #   poisson = Poisson.new(6)
  #   poisson.probability { |x| x == 4 } # => 0.133...
  def probability
    yield query = Query.new
    
    case query.condition
      when :==
        if query.value.is_a? Range
          probability do |x|
            x <= if query.value.exclude_end?
                   query.value.last - 1
                 else
                   query.value.last
                 end
          end - probability { |x| x < query.value.first }
        else
          (Math.exp(-@mean) * mean**query.value) / Math.factorial(query.value)
        end
      when :not_eql
        1 - probability { |x| x == query.value }
      when :<=
        (0..query.value).inject(0) do |sum, value|
          sum += probability { |x| x == value }
        end
      when :>=
        1 - probability { |x| x < query.value }
      when :<
        unless query.value == 0
          probability { |x| x <= (query.value - 1) }
        else
          0
        end
      when :>
        1 - probability { |x| x <= query.value }
    end
  end
  
  alias_method :p, :probability
  
  # If two poisson distributions are independent, you can add them to form a new Poisson. Example:
  #
  #   Poisson.new(2) + Poisson.new(5) # => Poisson.new(7)
  def + poisson
    self.class.new(@mean + poisson.mean)
  end
  
  # You can multiply a Poisson if the time period changes. Example:
  #
  #   accidents_per_hour = Poisson.new(4.5)
  #   accidents_per_two_hours = accidents_per_hour * 2 # => Poisson.new(9)
  def * multiplier
    self.class.new(@mean * multiplier)
  end
  
  # See the * method.
  def / divider
    self.class.new(@mean / divider)
  end
  
end
