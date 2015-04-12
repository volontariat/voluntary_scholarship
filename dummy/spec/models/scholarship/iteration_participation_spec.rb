require 'spec_helper'

describe Scholarship::IterationParticipation do
  describe 'validations' do
    describe '#accepted_team_membership_for_team_roles' do
      context 'no team role' do
        it 'sets no error' do
          iteration_participation = FactoryGirl.build(:scholarship_iteration_participation, roles: [:organizer])
          
          iteration_participation.valid?
          
          iteration_participation.errors[:team_id].empty?.should be_truthy
        end
      end
      
      context 'team role' do
        before :each do
          @iteration_participation = FactoryGirl.build(:scholarship_iteration_participation, team: nil, roles: [:student])
        end
        
        context 'team blank' do
          it 'sets an error' do
            @iteration_participation.valid?
            
            @iteration_participation.errors[:team_id].should include(I18n.t('errors.messages.blank'))
          end
        end
        
        context 'team present' do
          before :each do
            @team = FactoryGirl.create(:scholarship_team)
            @iteration_participation.team_id = @team.id
          end
          
          context 'without team membership' do
            it 'sets an error' do
              @iteration_participation.valid?
            
              @iteration_participation.errors[:team_id].should include(
                I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.no_team_membership')
              )
            end
          end
          
          context 'with team membership' do
            before :each do
              @team_membership = FactoryGirl.create(:scholarship_team_membership, team: @team, user: @iteration_participation.user, roles: [:student])
            end
            
            context 'team membership has not been accepted' do
              it 'sets an error' do
                @iteration_participation.valid?
              
                @iteration_participation.errors[:team_id].should include(
                  I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.no_accepted_team_membership')
                )
              end
            end
            
            context 'team membership has been accepted' do
              before :each do
                @team_membership.accept!
              end
              
              context 'roles include role which is not included in team membership roles' do
                it 'sets an error' do
                  @iteration_participation.roles = [:student, :mentor]
                  
                  @iteration_participation.valid?
                  
                  @iteration_participation.errors[:team_id].should include(
                    I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.team_role_not_included_in_team_membership_roles')
                  )
                end
              end
              
              context 'roles include no role which is not included in team membership roles' do
                it 'sets no error' do
                  @iteration_participation.valid?
          
                  @iteration_participation.errors[:team_id].empty?.should be_truthy
                end
              end
            end
          end
        end
      end
    end
  end
  
  describe 'callbacks' do
    describe 'accept_organization_owner_participations' do
      context 'user is organization owner' do
        it 'accepts the participation' do
          user = FactoryGirl.create(:user)
          organization = FactoryGirl.create(:organization, user: user)
          program = FactoryGirl.create(:scholarship_program, organization: organization)
          FactoryGirl.create(:scholarship_iteration)
          iteration = FactoryGirl.create(:scholarship_iteration, program: program)
          
          iteration_participation = FactoryGirl.create(:scholarship_iteration_participation, iteration: iteration, user: user)
          
          iteration_participation.accepted?.should be_truthy
        end
      end
      
      context 'user is not organization owner' do
        it 'does not accept the participation' do
          iteration_participation = FactoryGirl.create(:scholarship_iteration_participation)
          
          iteration_participation.requested?.should be_truthy
        end
      end
    end
  end
end
