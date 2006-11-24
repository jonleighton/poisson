class Poisson
  
  # You send queries to an instance of this class in the block from the Poisson#probability method.
  # There is no need to instantiate it directly.
  #
  # There are a number of different operators you can use. Note that only <tt>==</tt> accepts Ranges:
  #
  # [<tt>==</tt>] Equal to. Accepts:
  # * Integers: <tt>x == 5</tt>
  # * Ranges: <tt>x == (5..9)</tt> - This is the equivalent of saying "5 <= x <= 9"
  # [<tt>not_eql</tt>] Not equal to
  # [<tt><=</tt>] Less than or equal to
  # [<tt>>=</tt>] Greater than or equal to
  # [<tt><</tt>] Less than
  # [<tt>></tt>] Greater than
  class Query
    
    class InvalidQuery < Exception; end;
    
    attr_accessor :condition, :value # :nodoc:
    
    [:not_eql, :<=, :>=, :<, :>].each do |operator|
      define_method operator do |value|
        validate_value value
        @condition, @value = operator, value
      end
    end
    
    def == value # :nodoc:
      validate_value value, true
      @condition, @value = :==, value
    end
    
    protected
    
    def validate_value(value, allow_range = false) # :nodoc:
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
                  elsif value.first > value.last
                    "ranges cannot go down"
                  elsif value.to_a.length <= 1
                    "range must include at least two values"
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
end
