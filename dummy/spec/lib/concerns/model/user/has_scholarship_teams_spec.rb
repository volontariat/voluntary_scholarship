require 'spec_helper'

describe VoluntaryScholarship::Concerns::Model::User::HasScholarshipTeams do
  describe '#scholarship_teams_as_leader' do
    it 'returns only the teams where the user is a team leader' do
      team = FactoryGirl.create(:scholarship_team)
      user = FactoryGirl.create(:user)
      FactoryGirl.create(:scholarship_team_membership, user: user, roles: [:student])
      FactoryGirl.create(:scholarship_team_membership, team: team, user: user, roles: [:team_leader])
      
      user.scholarship_teams_as_leader.to_a.should == [team]
    end 
  end
  
  describe '#scholarship_iterations_as_organization_owner' do
    it 'returns only the iterations where the user is an organization owner' do
      user = FactoryGirl.create(:user)
      organization = FactoryGirl.create(:organization, user: user)
      program = FactoryGirl.create(:scholarship_program, organization: organization)
      FactoryGirl.create(:scholarship_iteration)
      iteration = FactoryGirl.create(:scholarship_iteration, program: program)
      
      user.scholarship_iterations_as_organization_owner.to_a.should == [iteration]
    end
  end
  
  describe '#is_leader_of_scholarship_team?' do
    context 'is a leader' do
      it 'returns true' do
        membership = FactoryGirl.create(:scholarship_team_membership, roles: [:team_leader])
        
        membership.user.is_leader_of_scholarship_team?(membership.team).should be_truthy
      end
    end
    
    context 'is a student' do
      it 'returns false' do
        membership = FactoryGirl.create(:scholarship_team_membership, roles: [:student])
        
        membership.user.is_leader_of_scholarship_team?(membership.team).should be_falsey
      end
    end
  end
end
