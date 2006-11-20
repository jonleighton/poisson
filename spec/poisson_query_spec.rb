require File.dirname(__FILE__) + '/spec_helper'

context "A poisson query of '== 8'" do

  setup do
    @query = Poisson::Query.new
    @query == 8
  end

  specify "should have a condition of :==" do
    @query.condition.should_be :==
  end
  
  specify "should have a value of 8" do
    @query.value.should_be 8
  end

end

context "A poisson query of '<= 40'" do

  setup do
    @query = Poisson::Query.new
    @query <= 40
  end

  specify "should have a condition of :<=" do
    @query.condition.should_be :<=
  end

end

context "A poisson query of '>= 3" do

  setup do
    @query = Poisson::Query.new
    @query >= 3
  end
  
  specify "should have a condition of :>=" do
    @query.condition.should_be :>=
  end

end

context "A poisson query of '> 9'" do

  setup do
    @query = Poisson::Query.new
    @query > 9
  end
  
  specify "should have a condition of :>" do
    @query.condition.should_be :>
  end
  
end

context "A poisson query of '< 5'" do

  setup do
    @query = Poisson::Query.new
    @query < 5
  end
  
  specify "should have a condition of :<" do
    @query.condition.should_be :<
  end
  
end
