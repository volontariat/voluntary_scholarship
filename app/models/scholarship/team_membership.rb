module Scholarship
  class TeamMembership < ActiveRecord::Base
    EVENTS = [:accept, :deny, :change_roles]
    ROLES = [:team_leader, :student, :coach, :mentor, :supervisor]
    
    self.table_name = 'scholarship_team_memberships'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :team, class_name: 'Scholarship::Team'
    belongs_to :user
    
    scope :of_team_leader, ->(user) { where(team_id: user.scholarship_teams_as_leader.map(&:id)) }
    
    scope :order_by_user_full_name, -> do 
      joins(:user).
      select('scholarship_team_memberships.*, CONCAT(users.first_name, " ", users.last_name) AS user_full_name').
      order('user_full_name ASC')
    end
    
    scope :requested, -> { where(state: 'requested') }
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
        transition :accepted => :changed_roles
      end
    end
  end
end