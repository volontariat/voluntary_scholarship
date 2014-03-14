module Scholarship
  module RoleRequest
    extend ActiveSupport::Concern
  
    included do
      const_set 'EVENTS', [:accept, :deny, :change_roles]
      
      scope :order_by_user_full_name, -> do 
        joins(:user).
        select(table_name + '.*, CONCAT(users.first_name, " ", users.last_name) AS user_full_name').
        order('user_full_name ASC')
      end
      
      scope :requested, -> { where(state: 'requested') }
      scope :accepted, -> { where(state: 'accepted') }
      scope :denied, -> { where(state: 'denied') }
      scope :changed_roles, -> { where(state: 'changed_roles') }
      
      validates :roles, presence: true
      
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
end