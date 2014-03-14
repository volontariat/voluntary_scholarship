module VoluntaryScholarship
  class Ability
    def self.after_initialize
      Proc.new do |ability, user, options|
        ability.can :read, [
          Scholarship::Team, Scholarship::TeamMembership, Scholarship::Program, Scholarship::Iteration, Scholarship::IterationParticipation
        ]
        
        if user.present?
          ability.can(:restful_actions, Scholarship::Team) {|team| team.new_record? || user.is_leader_of_scholarship_team?(team) }
          
          ability.can(:restful_actions, Scholarship::TeamMembership) do |membership| 
            membership.new_record? || membership.user_id == user.id || user.is_leader_of_scholarship_team?(membership.team)
          end
          
          ability.can([:with_state] + Scholarship::TeamMembership::EVENTS, Scholarship::TeamMembership) do |membership|
            user.is_leader_of_scholarship_team?(membership.team)
          end
         
          ability.can(:restful_actions, Scholarship::IterationParticipation) do |participation| 
            participation.new_record? || participation.user_id == user.id || user.id == participation.iteration.program.organization.user_id
          end
          
          ability.can([:with_state] + Scholarship::IterationParticipation::EVENTS, Scholarship::IterationParticipation) do |participation|
            user.id == participation.iteration.program.organization.user_id
          end
          
          ability.can(:restful_actions, Scholarship::Program) {|program| program.organization.blank? || program.organization.user_id == user.id }
          ability.can(:restful_actions, Scholarship::Iteration) {|iteration| iteration.program.blank? || iteration.program.organization.user_id == user.id }
        end
      end
    end
  end
end
