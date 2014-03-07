module VoluntaryScholarship
  class Ability
    def self.after_initialize
      Proc.new do |ability, user, options|
        ability.can :read, [Scholarship::Program]
        
        if user.present?
          ability.can(:restful_actions, Scholarship::Program) {|program| program.organization.try(:user_id) == user.id }
        end
      end
    end
  end
end
