module VoluntaryScholarship
  class Ability
    def self.after_initialize
      Proc.new do |ability, user, options|
        ability.can :read, [Scholarship::Program, Scholarship::Iteration]
        
        if user.present?
          ability.can(:restful_actions, Scholarship::Program) {|program| program.organization.blank? || program.organization.user_id == user.id }
          ability.can(:restful_actions, Scholarship::Iteration) {|iteration| iteration.program.blank? || iteration.program.organization.user_id == user.id }
        end
      end
    end
  end
end
