Given /^a scholarship iteration participation for me$/ do
  @iteration_participation = FactoryGirl.create(:scholarship_iteration_participation, user: @me) 
  @iteration = @iteration_participation.iteration
end

Given /^a requested scholarship iteration participation for my iteration$/ do
  steps %Q(
    Given an organization named "organization 1" assigned to me
    And a scholarship program named "scholarship program 1" assigned to my organization
    And a scholarship iteration named "scholarship iteration 1" assigned to my scholarship program
  )
  @iteration_participation = FactoryGirl.create(:scholarship_iteration_participation, iteration: @iteration) 
end