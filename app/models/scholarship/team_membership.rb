module Scholarship
  class TeamMembership < ActiveRecord::Base
    ROLES = [:team_leader, :student, :coach, :mentor, :supervisor]
    
    self.table_name = 'scholarship_team_memberships'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :team, class_name: 'Scholarship::Team'
    belongs_to :user
    
    scope :accepted, -> { where(state: 'accepted') }
    scope :denied, -> { where(state: 'denied') }
    scope :changed_roles, -> { where(state: 'changed_roles') }
        
    validates :team_id, presence: true
    validates :user_id, presence: true, uniqueness: { scope: :team_id }
    validates :roles, presence: true
    
    attr_accessible :team_id, :roles
    
    bitmask :roles, as: ROLES
    
    state_machine :state, initial: :requested do
      event :accept do
        transition [:requested, :denied, :changed_roles] => :accepted
      end
      
      event :deny do
        transition [:requested, :accepted] => :denied
      end
      
      event :change_roles do
        transition :requested => :changed_roles
      end
    end
  end
end