require 'spec_helper'

describe VoluntaryScholarship::IterationParticipationsHelper do
  describe '#can_update_scholarship_iteration_participation_roles?' do
    context 'user is master' do
      it 'returns true' do
        stub!(:current_user).and_return(FactoryGirl.create(:master_user))
        
        can_update_scholarship_iteration_participation_roles?(FactoryGirl.build(:scholarship_iteration_participation)).should be_true
      end
    end
      
    context 'user has no roles' do
      before :each do
        @user = FactoryGirl.create(:user); stub!(:current_user).and_return(@user)
      end
      
      context 'user can update iteration participation' do
        before :each do
          @iteration_participation = FactoryGirl.create(:scholarship_iteration_participation, user: @user)  
          stub!(:can?).with(:update, @iteration_participation).and_return true
        end
        
        context 'user is organization owner' do
          it 'returns true' do
            @iteration_participation.iteration.program.organization.update_attribute(:user_id, @user.id)
            
            can_update_scholarship_iteration_participation_roles?(@iteration_participation).should be_true
          end
        end
        
        context 'user is no leader of team' do
          context 'iteration participation is not accepted' do
            it 'returns false' do
              can_update_scholarship_iteration_participation_roles?(@iteration_participation).should be_false
            end
          end
          
          context 'iteration participation is accepted' do
            it 'returns false' do
              @iteration_participation.update_attribute(:state, 'accepted')
              
              can_update_scholarship_iteration_participation_roles?(@iteration_participation).should be_true
            end
          end
        end
      end
      
      context 'user can not update iteration participation' do
        before :each do
          @iteration_participation = FactoryGirl.create(:scholarship_iteration_participation)  
          stub!(:can?).with(:update, @iteration_participation).and_return false
        end
        
        it 'returns false' do
          can_update_scholarship_iteration_participation_roles?(@iteration_participation).should be_false
        end
      end
    end
  end
end
