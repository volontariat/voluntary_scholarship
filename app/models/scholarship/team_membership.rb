module Scholarship
  class TeamMembership < ActiveRecord::Base
    ROLES = [:team_leader, :student, :coach, :mentor, :supervisor]
    
    self.table_name = 'scholarship_team_memberships'
    
    include Applicat::Mvc::Model::Resource::Base
    include RoleRequest
    
    belongs_to :team, class_name: 'Scholarship::Team'
    belongs_to :user
    
    scope :of_team_leader, ->(user) { where(team_id: user.scholarship_teams_as_leader.map(&:id)) }
        
    validates :team_id, presence: true
    validates :user_id, presence: true, uniqueness: { scope: :team_id }
    
    attr_accessible :team_id, :roles
    
    bitmask :roles, as: ROLES
  end
end