# Bob has traveled 200 km in four hours. Using variables, print a message
# showing his travel distance, time, and average velocity
#
# travel_distance = 200
# travel_time = 4
# IO.puts "Travel distance: #{travel_distance}km"
# IO.puts "Travel time: #{4}hs"
# IO.puts "Average velocity: #{travel_distance/travel_time}km/h"
#-------------------------------------------------------------------------

# Build an anonymous function that applies a tax of 12% to a given price.
# It should print a message with the new price and tax value. Bind the
# anonymous function to a variable called apply_tax. You should use apply_tax
# with Enum.each/2, like in the following example. Don’t worry about Enum.each/2
# now; you’ll see it in detail in Chapter 5, Using Higher-Order Functions, on
# page 81. You only need to know that Enum.each/2 will execute apply_tax in
# each item of a list.
# Enum.each [12.5, 30.99, 250.49, 18.80], apply_tax
# # Price: 14.0 - Tax: 1.5
# # Price: 34.7088 - Tax: 3.7188
# # Price: 280.5488 - Tax: 30.0588
# # Price: 21.056 - Tax: 2.256
# defmodule Tax do
  #apply_tax = fn price ->
 #   IO.puts 'Price: #{price} - Tax: #{price * 0.12}'
#  end
#  Enum.each [12.5, 30.99, 250.49, 18.80], apply_tax
# end


# Create a module called MatchstickFactory and a function called boxes/1. The
# function will calculate the number of boxes necessary to accommodate
# some matchsticks. It returns a map with the number of boxes necessary
# for each type of box. The factory has three types of boxes: the big ones
# hold fifty matchsticks, the medium ones hold twenty, and the small ones
# hold five. The boxes can’t have fewer matchstick that they can hold; they
# must be full. The returning map should contain the remaining matchsticks. It should work like this:
# MatchstickFactory.boxes(98)
# # %{big: 1, medium: 2, remaining_matchsticks: 3, small: 1}
# MatchstickFactory.boxes(39)
# # %{big: 0, medium: 1, remaining_matchsticks: 4, small: 3}
# Tip: You’ll need to use the rem/2 and div/2 functions.8

#rem(dividend, divisor)
#Computes the remainder of an integer division.

#div(dividend, divisor)
#Performs an integer division.

defmodule MatchstickFactory do
  def boxes(matchsticks) do
    %{big: div(matchsticks, 50), medium: div(rem(matchsticks, 50), 20), remaining_matchsticks: rem(matchsticks, 5), small: div(rem(rem(matchsticks, 50), 20), 5)}
  end
end
IO.inspect MatchstickFactory.boxes(98)
IO.inspect MatchstickFactory.boxes(39)
