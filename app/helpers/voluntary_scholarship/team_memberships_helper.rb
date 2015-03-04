module VoluntaryScholarship
  module TeamMembershipsHelper
    def can_update_scholarship_team_membership_roles?(team_membership)
      return false unless user_signed_in?
      
      team_membership.new_record? || 
      current_user.is_master? || 
      current_user.is_leader_of_scholarship_team?(team_membership.team) ||
      (can?(:update, team_membership) && team_membership.accepted?)
    end
    
    def destroy_scholarship_team_membership_link(team_membership)
      link_to(
        t('scholarship_team_memberships.destroy.title'), 
        scholarship_team_membership_path(team_membership.id), id: "team_membership_#{team_membership.id}", method: :delete, 
        data: { confirm: t('general.questions.are_you_sure') },
        onclick: "delete_link('team_membership_#{team_membership.id}'); return false;"
      )
    end
  end
end