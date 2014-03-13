require 'spec_helper'

describe VoluntaryScholarship::Concerns::Model::User::HasScholarshipTeams do
  describe '#is_leader_of_scholarship_team?' do
    context 'is a leader' do
      it 'returns true' do
        membership = FactoryGirl.create(:scholarship_team_membership, roles: [:team_leader])
        
        membership.user.is_leader_of_scholarship_team?(membership.team).should be_true
      end
    end
    
    context 'is a student' do
      it 'returns false' do
        membership = FactoryGirl.create(:scholarship_team_membership, roles: [:student])
        
        membership.user.is_leader_of_scholarship_team?(membership.team).should be_false
      end
    end
  end
end
