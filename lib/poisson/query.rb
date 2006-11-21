class Poisson::Query
  
  class InvalidQuery < Exception; end;
  
  attr_accessor :condition, :value
  
  [:not_eql, :<=, :>=, :<, :>].each do |operator|
    define_method operator do |value|
      validate_value value
      @condition, @value = operator, value
    end
  end
  
  def == value
    validate_value value, true
    @condition, @value = :==, value
  end
  
  protected
  
  def validate_value(value, allow_range = false)
    error = nil
    
    error = if !allow_range && value.is_a?(Range)
              "range not allow for this operator"
            elsif !(value.is_a?(Integer) || value.is_a?(Range))
              "value must be integer or a range"
            elsif value.is_a?(Range) && !value.first.is_a?(Integer)
              "range values must be integers"
            elsif value.is_a?(Range) && value.to_a.length <= 1
              "range must include at least two values"
            elsif (value.is_a?(Range) && value.first < 0) || (value.is_a?(Integer) && value < 0)
              "query values must be positive"
            elsif value.is_a?(Range) && value.first > value.last
              "ranges cannot go down"
            end
    
    raise InvalidQuery, error if error
  end
  
end
