def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.count > 0
    association_name.to_s.classify.constantize.last
  else
    Factory.create association_name.to_s.singularize.to_sym
  end
  
  resource.send(association_name).send('<<', association) if association
end

FactoryGirl.define do
  Voluntary::Test::RspecHelpers::Factories.code.call(self)
  
  factory :scholarship_program, class: Scholarship::Program do
    association :organization
    sequence(:name) { |n| "scholarship program #{n}#{r_str}" } 
  end
  
  factory :scholarship_team, class: Scholarship::Team do
    association :leader, factory: :user
    kind 'sponsored'
    sequence(:name) { |n| "scholarship program #{n}#{r_str}" } 
  end
  
  factory :scholarship_team_membership, class: Scholarship::TeamMembership do
    association :team, factory: :scholarship_team
    association :user
    roles [:student]
  end
  
  factory :scholarship_iteration, class: Scholarship::Iteration do
    association :program, factory: :scholarship_program
    from Date.new(2014, 6, 1)
    to Date.new(2014, 9, 1)
  end
  
  factory :scholarship_iteration_participation, class: Scholarship::IterationParticipation do
    association :iteration, factory: :scholarship_iteration
    association :user
    association :team, factory: :scholarship_team
    roles [:student]
    
    after_build do |iteration_participation|
      team_roles = iteration_participation.roles.select{|role| Scholarship::TeamMembership::ROLES.include?(role) }
      
      if team_roles.any? && iteration_participation.team.present?
        team_membership = FactoryGirl.create(
          :scholarship_team_membership, team: iteration_participation.team, user: iteration_participation.user, roles: team_roles
        )
        team_membership.accept!
      end
    end
  end
end