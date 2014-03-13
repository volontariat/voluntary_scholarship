Given /^a scholarship team membership for me$/ do
  @team_membership = FactoryGirl.create(:scholarship_team_membership, user: @me) 
  @team = @team_membership.team
end