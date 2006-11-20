class Poisson::Query
  
  attr_accessor :condition, :value
  
  [:==, :<=, :>=, :<, :>].each do |operator|
    define_method operator do |value|
      @condition = operator
      @value = value
    end
  end
  
end
