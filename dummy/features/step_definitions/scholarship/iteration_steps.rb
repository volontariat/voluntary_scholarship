Given /^a scholarship iteration named "([^\"]*)"$/ do |name|
  @iteration = FactoryGirl.create(:scholarship_iteration, name: name) 
  @program = @iteration.program
  @iteration.reload
end

Given /^a scholarship iteration named "([^\"]*)" assigned to my scholarship program/ do |name|
  @iteration = FactoryGirl.create(:scholarship_iteration, name: name, program: @program) 
  @iteration.reload
end

Given /^2 scholarship iterations assigned to my scholarship program/ do
  FactoryGirl.create(
    :scholarship_iteration, name: 'scholarship iteration 1', program: @program, 
    from: Date.new(2014, 6, 1), to: Date.new(2014, 9, 1)
  )
  FactoryGirl.create(
    :scholarship_iteration, name: 'scholarship iteration 2', program: @program, 
    from: Date.new(2013, 6, 1), to: Date.new(2013, 9, 1)
  )
end
