require 'spec_helper'

describe VoluntaryScholarship::TeamMembershipsHelper do
  describe '#can_update_scholarship_team_membership_roles?' do
    context 'user is master' do
      it 'returns true' do
        stub!(:current_user).and_return(FactoryGirl.create(:master_user))
        
        can_update_scholarship_team_membership_roles?(FactoryGirl.build(:scholarship_team_membership)).should be_true
      end
    end
      
    context 'user has no roles' do
      before :each do
        @user = FactoryGirl.create(:user); stub!(:current_user).and_return(@user)
      end
      
      context 'user can update membership' do
        before :each do
          @membership = FactoryGirl.create(:scholarship_team_membership, user: @user)  
          stub!(:can?).with(:update, @membership).and_return true
        end
        
        context 'user is leader of team' do
          it 'returns true' do
            @membership.update_attribute(:roles, [:team_leader])
            
            can_update_scholarship_team_membership_roles?(@membership).should be_true
          end
        end
        
        context 'user is no leader of team' do
          context 'membership is not accepted' do
            it 'returns false' do
              can_update_scholarship_team_membership_roles?(@membership).should be_false
            end
          end
          
          context 'membership is accepted' do
            it 'returns false' do
              @membership.update_attribute(:state, 'accepted')
              
              can_update_scholarship_team_membership_roles?(@membership).should be_true
            end
          end
        end
      end
      
      context 'user can not update membership' do
        before :each do
          @membership = FactoryGirl.create(:scholarship_team_membership)  
          stub!(:can?).with(:update, @membership).and_return false
        end
        
        it 'returns false' do
          can_update_scholarship_team_membership_roles?(@membership).should be_false
        end
      end
    end
  end
end
