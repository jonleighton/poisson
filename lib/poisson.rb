$: << File.dirname(__FILE__)
%w(math/math poisson/poisson poisson/query).each { |r| require r }
