class Poisson::Query
  
  attr_accessor :condition, :value
  
  [:==, :not_eql, :<=, :>=, :<, :>].each do |operator|
    define_method operator do |value|
      @condition, @value = operator, value
    end
  end
  
end
