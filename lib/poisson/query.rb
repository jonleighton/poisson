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
    
    catch :error_set do
    
      if !(value.is_a?(Integer) || value.is_a?(Range))
        error = "value must be integer or a range"
        throw :error_set
      end
      
      if value.is_a?(Range)
        error = if !allow_range
                  "range not allowed for this operator"
                elsif !value.first.is_a?(Integer)
                  "range values must be integers"
                elsif value.to_a.length <= 1
                  "range must include at least two values"
                elsif value.first > value.last
                  "ranges cannot go down"
                end
        throw :error_set if error
      end
      
      if (value.is_a?(Range) && value.first < 0) || (value.is_a?(Integer) && value < 0)
        error = "query values must be positive"
        throw :error_set
      end
    
    end
    
    raise InvalidQuery, error if error
  end
  
end
