require File.dirname(__FILE__) + '/spec_helper'

context "The Math.factorial method" do

  specify "should be 1 when passed 0" do
    Math.factorial(0).should_be 1
  end
  
  specify "should be 720 when passed 6" do
    Math.factorial(6).should_be 720
  end

end
