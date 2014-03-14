module VoluntaryScholarship
  module Concerns
    module Model
      module User
        module HasScholarshipTeams
          extend ActiveSupport::Concern
          
          def scholarship_teams
            Scholarship::Team.joins(:memberships).where('scholarship_team_memberships.user_id = ?', id)
          end
          
          def scholarship_teams_as_leader
            scholarship_teams.merge(Scholarship::TeamMembership.with_roles(:team_leader))
          end
          
          def scholarship_iterations_as_organization_owner
            Scholarship::Iteration.joins(program: :organization).where('organizations.user_id = ?', id)
          end
          
          def is_leader_of_scholarship_team?(team)
            team.memberships.where(user_id: id).with_roles(:team_leader).any?
          end
          
          def is_member_of_scholarship_team?(team)
            team.memberships.where(user_id: id).any?
          end
          
          def membership_of_scholarship_team(team)
            team.memberships.where(user_id: id).first
          end
          
          def is_participant_of_scholarship_iteration?(iteration)
            iteration.participations.where(user_id: id).any?
          end
          
          def participation_of_scholarship_iteration(iteration)
            iteration.participations.where(user_id: id).first
          end
        end
      end
    end
  end
end