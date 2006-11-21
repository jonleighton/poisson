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

context "A poisson query of 'not_eql 12'" do

  setup do
    @query = Poisson::Query.new
    @query.not_eql 12
  end
  
  specify "should have a condition of :not_eql" do
    @query.condition.should_be :not_eql
  end
  
end

context "A poisson query" do

  setup do
    @query = Poisson::Query.new
  end

  specify "should raise Poisson::Query::InvalidQuery when passed a negative number" do
    proc { @query == -6 }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a range starting with a negative number" do
    proc { @query == (-6..4) }.should_raise Poisson::Query::InvalidQuery
  end

  specify "should raise Poisson::Query::InvalidQuery when passed a range that decreases" do
    proc { @query == (6..2) }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a range to a condition other than ==" do
    proc { @query < (5..8) }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should not raise Poisson::Query::InvalidQuery when passed a range to a == condition" do
    proc { @query == (5..8) }.should_not_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a non-integer-or-range" do
    proc { @query < "Pushing through the walls of dark imagination" }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should not raise Poisson::Query::InvalidQuery when passed a range" do
    proc { @query == (1..3) }.should_not_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a range containing non-integers" do
    proc { @query == ("a".."t") }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a range containing floats" do
    proc { @query == (2.8..8.9) }.should_raise Poisson::Query::InvalidQuery
  end
  
  specify "should raise Poisson::Query::InvalidQuery when passed a float" do
    proc { @query == 9.2 }.should_raise Poisson::Query::InvalidQuery
  end
  
end
