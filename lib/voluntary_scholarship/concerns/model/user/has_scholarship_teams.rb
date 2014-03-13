module VoluntaryScholarship
  module Concerns
    module Model
      module User
        module HasScholarshipTeams
          extend ActiveSupport::Concern
          
          def is_leader_of_scholarship_team?(team)
            team.memberships.where(user_id: id).with_roles(:team_leader).any?
          end
          
          def is_member_of_scholarship_team?(team)
            team.memberships.where(user_id: id).any?
          end
          
          def membership_of_scholarship_team(team)
            team.memberships.where(user_id: id).first
          end
        end
      end
    end
  end
end