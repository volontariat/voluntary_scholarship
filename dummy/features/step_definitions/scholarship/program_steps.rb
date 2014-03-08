Given /^a scholarship program named "([^\"]*)"$/ do |name|
  @program = FactoryGirl.create(:scholarship_program, name: name) 
  @program.reload
end

Given /^a scholarship program named "([^\"]*)" assigned to my organization$/ do |name|
  @program = FactoryGirl.create(:scholarship_program, name: name, organization: @organization) 
  @program.reload
end

Given /^2 scholarship programs assigned to my organization$/ do
  FactoryGirl.create(:scholarship_program, name: 'scholarship program 1', organization: @organization)
  FactoryGirl.create(:scholarship_program, name: 'scholarship program 2', organization: @organization)
end
