Given /^a scholarship team named "([^\"]*)"$/ do |name|
  @team = FactoryGirl.create(:scholarship_team, name: name) 
  @team.reload
end

Given /^a scholarship team named "([^\"]*)" with me as leader$/ do |name|
  @team = FactoryGirl.create(:scholarship_team, name: name, leader: @me) 
  @team.reload
end

Given /^2 scholarship teams with me as leader$/ do
  FactoryGirl.create(:scholarship_team, name: 'scholarship team 1', leader: @me)
  FactoryGirl.create(:scholarship_team, name: 'scholarship team 2', leader: @me)
end
