module Scholarship
  class TeamMembership < ActiveRecord::Base
    self.table_name = 'scholarship_team_memberships'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :team, class_name: 'Scholarship::Team'
    belongs_to :user
    
    validates :team_id, presence: true
    validates :user_id, presence: true, uniqueness: { scope: :team_id }
    
    attr_accessible :team_id, :roles
    
    bitmask :roles, as: [:team_leader]
  end
end