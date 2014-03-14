module VoluntaryScholarship
  module IterationParticipationsHelper
    def can_update_scholarship_iteration_participation_roles?(iteration_participation)
      iteration_participation.new_record? || 
      current_user.is_master? || 
      current_user.id == iteration_participation.iteration.program.organization.user_id ||
      (can?(:update, iteration_participation) && iteration_participation.accepted?)
    end
    
    def destroy_scholarship_iteration_participation_link(iteration_participation)
      link_to(
        t('scholarship_iteration_participations.destroy.title'), 
        scholarship_iteration_participation_path(iteration_participation.id), id: "iteration_participation_#{iteration_participation.id}", method: :delete, 
        data: { confirm: t('general.questions.are_you_sure') },
        onclick: "delete_link('iteration_participation_#{iteration_participation.id}'); return false;"
      )
    end
  end
end