require 'spec_helper'

describe Scholarship::Team do
  describe '#create' do
    describe 'create team leader membership' do
      context 'team membership creation successful' do
        it 'creates also a team leader membership' do
          user = FactoryGirl.create(:user)
          
          team = Scholarship::Team.new(kind: 'sponsored', name: 'Dummy')
          team.leader = user
          team.save!
          
          team_membership = Scholarship::TeamMembership.where(team_id: team.id, user_id: user.id).first
          team_membership.roles.should == [:team_leader]
          team_membership.accepted?.should be_true
        end
      end
      
      context 'team membership creation failed' do
        it 'creates no team and no team leader membership' do
          team = Scholarship::Team.new(kind: 'sponsored', name: 'Dummy')
          team.save
          
          team.valid?.should be_false
          team.errors.full_messages.should include('Memberships is invalid')
          Scholarship::Team.count.should == 0
          Scholarship::TeamMembership.count.should == 0
        end
      end
    end
  end
end