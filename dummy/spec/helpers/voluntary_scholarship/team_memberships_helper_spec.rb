require 'spec_helper'

describe VoluntaryScholarship::TeamMembershipsHelper do
  before :each do
    allow(self).to receive(:user_signed_in?).and_return true
  end
  
  describe '#can_update_scholarship_team_membership_roles?' do
    context 'user is master' do
      it 'returns true' do
        allow(self).to receive(:current_user).and_return FactoryGirl.create(:master_user)
        
        can_update_scholarship_team_membership_roles?(FactoryGirl.build(:scholarship_team_membership)).should be_truthy
      end
    end
      
    context 'user has no roles' do
      before :each do
        @user = FactoryGirl.create(:user)
        allow(self).to receive(:current_user).and_return @user
      end
      
      context 'user can update membership' do
        before :each do
          @membership = FactoryGirl.create(:scholarship_team_membership, user: @user)
          allow(self).to receive(:can?).with(:update, @membership).and_return true
        end
        
        context 'user is leader of team' do
          it 'returns true' do
            @membership.update_attribute(:roles, [:team_leader])
            
            can_update_scholarship_team_membership_roles?(@membership).should be_truthy
          end
        end
        
        context 'user is no leader of team' do
          context 'membership is not accepted' do
            it 'returns false' do
              can_update_scholarship_team_membership_roles?(@membership).should be_falsey
            end
          end
          
          context 'membership is accepted' do
            it 'returns false' do
              @membership.update_attribute(:state, 'accepted')
              
              can_update_scholarship_team_membership_roles?(@membership).should be_truthy
            end
          end
        end
      end
      
      context 'user can not update membership' do
        before :each do
          @membership = FactoryGirl.create(:scholarship_team_membership)
          allow(self).to receive(:can?).with(:update, @membership).and_return false
        end
        
        it 'returns false' do
          can_update_scholarship_team_membership_roles?(@membership).should be_falsey
        end
      end
    end
  end
end
