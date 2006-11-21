require File.dirname(__FILE__) + '/spec_helper'

context "A poisson distribution with mean 4" do

  setup do
    @poisson = Poisson.new 4
  end

  specify "should have a mean of 4" do
    @poisson.mean.should == 4
  end
  
  specify "should have a mean of 8 after mean is set to 8" do
    @poisson.mean = 8
    @poisson.mean.should == 8
  end
  
  specify "should return a poisson with mean 6.5 when added to a poisson of mean 2.5" do
    (@poisson + Poisson.new(2.5)).mean.should == 6.5
  end
  
  specify "should have roughly 0.0183 probability of being less than or equal to 0" do
    @poisson.probability { |x| x <= 0 }.should_be_close 0.0183, 0.0005
  end
  
  specify "should have roughly 0.8046 probability of not being 4" do
    @poisson.probability { |x| x.not_eql 4 }.should_be_close 0.8046, 0.0005
  end
  
end

context "A poisson distribution with mean 6" do
  
  setup do
    @poisson = Poisson.new 6
  end
  
  specify "should have roughly 0.133 probability of being 4" do
    @poisson.probability { |x| x == 4 }.should_be_close 0.133, 0.005
  end
  
  specify "should have roughly 0.103 probability of being 8" do
    @poisson.probability { |x| x == 8 }.should_be_close 0.103, 0.005
  end
  
  specify "should have roughly 0.7149 probability of being greater than or equal to 5" do
    @poisson.probability { |x| x >= 5 }.should_be_close 0.7149, 0.0005
  end
  
  specify "should have roughly 0.0620 probability of being less than 3" do
    @poisson.probability { |x| x < 3 }.should_be_close 0.0620, 0.0005
  end
  
  specify "should have roughly 0.1487 probability of being greater than 0 and less than 4" do
    @poisson.probability { |x| x == (1...4) }.should_be_close 0.1487, 0.0005
  end

end

context "A poisson distribution with mean 3.5" do

  setup do
    @poisson = Poisson.new 3.5
  end
  
  specify "should have roughly 0.8576 probability of being less than or equal to 5" do
    @poisson.probability { |x| x <= 5 }.should_be_close 0.8576, 0.0005
  end
  
  specify "should have roughly 0.0653 probability of being greater than 6" do
    @poisson.probability { |x| x > 6 }.should_be_close 0.0653, 0.0005
  end
  
  specify "should have roughly 0.7988 probability of being greater than or equal to 2 and less than or equal to 6" do
    @poisson.probability { |x| x == (2..6) }.should_be_close 0.7988, 0.0005
  end

end

context "An attempt to create a poisson distribution with mean -6" do

  specify "should raise Poisson::NegativeMean" do
    proc { Poisson.new -6 }.should_raise Poisson::InvalidMean
  end

end

context "An attempt to create a poisson distribution with a non-numeric mean" do

  specify "should raise Poisson::NegativeMean" do
    proc { Poisson.new "When I argue I see shapes" }.should_raise Poisson::InvalidMean
  end

end
