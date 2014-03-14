module Scholarship
  class IterationParticipation < ActiveRecord::Base
    ROLES = [:student, :coach, :mentor, :helpdesk, :supervisor, :organizer, :developer]
    
    self.table_name = 'scholarship_iteration_participations'
    
    include Applicat::Mvc::Model::Resource::Base
    include RoleRequest
    
    belongs_to :iteration, class_name: 'Scholarship::Iteration'
    belongs_to :user
    belongs_to :team, class_name: 'Scholarship::Team'
        
    scope :of_organization_owner, ->(user) { where(iteration_id: user.scholarship_iterations_as_organization_owner.map(&:id)) }    
        
    validates :iteration_id, presence: true
    validates :user_id, presence: true, uniqueness: { scope: :iteration_id }
    validate :accepted_team_membership_for_team_roles
    
    attr_accessible :iteration_id, :team_id, :roles
    
    bitmask :roles, as: ROLES
    
    after_create :accept_organization_owner_participations
    
    private
    
    def accepted_team_membership_for_team_roles
      team_roles = roles.select{|role| TeamMembership::ROLES.include?(role) }
      
      return unless team_roles.any?
      
      if team_id.blank?
        errors.add(:team_id, I18n.t('errors.messages.blank'))
        return
      end
      
      unless team_membership = team.memberships.where(user_id: user_id).first
        errors.add(
          :team_id,
          I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.no_team_membership')
        )
        
        return
      end
      
      unless team_membership.accepted?
        errors.add(
          :team_id,
          I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.no_accepted_team_membership')
        )
      end
      
      if team_roles.select{|role| !team_membership.roles.include?(role)}.any?
        errors.add(
          :team_id,
          I18n.t('activerecord.errors.models.scholarship/iteration_participation.attributes.team_id.team_role_not_included_in_team_membership_roles')
        )
      end
    end
    
    def accept_organization_owner_participations
      accept! if iteration.program.organization.user_id == user_id
    end
  end
end