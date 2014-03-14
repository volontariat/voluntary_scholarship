module VoluntaryScholarship
  module Navigation
    def self.voluntary_menu_customization
      voluntary_menu_options.each do |resource, options|
        options.each do |option, value|
          ::Voluntary::Navigation::Base.add_menu_option(resource, option, value)
        end
      end
    end
    
    def self.voluntary_menu_options
      {
        organizations: {
          after_resource_has_many: Proc.new do |organization, options|
            organization.item :programs, I18n.t('scholarship_programs.index.title'), organization_scholarship_programs_path(@organization)  
          end
        }
      }
    end
    
    def self.code
      Proc.new do |navigation|
        navigation.items do |primary|
          primary.dom_class = 'nav'
          
          instance_exec primary, VoluntaryScholarship::Navigation.voluntary_menu_options[:organizations], &::Voluntary::Navigation.menu_code(:organizations)
          
          primary.item :scholarship_programs, I18n.t('scholarship_programs.index.short_title'), scholarship_programs_path do |programs|
            programs.item :new, I18n.t('general.new'), new_scholarship_program_path
            
            unless (@program.new_record? rescue true)
              programs.item :show, "#{@program.name} (#{@program.organization.name})", scholarship_program_path(@program) do |program|
                if can? :destroy, @program
                  program.item :destroy, I18n.t('general.destroy'), scholarship_program_path(@program), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                end
      
                program.item :show, I18n.t('general.details'), "#{scholarship_program_path(@program)}#top"
                program.item :edit, I18n.t('general.edit'), edit_scholarship_program_path(@program) if can? :edit, @program
                program.item :iterations, I18n.t('scholarship_iterations.index.short_title'), scholarship_program_iterations_path(@program) do |iterations|
                  iterations.item :new, I18n.t('general.new'), new_scholarship_program_iteration_path(@program)
                
                  unless (@iteration.new_record? rescue true)
                    iterations.item(
                      :show, @iteration.to_s, 
                      scholarship_iteration_path(@iteration) 
                    ) do |iteration|
                      if can? :destroy, @iteration
                        iteration.item :destroy, I18n.t('general.destroy'), scholarship_iteration_path(@iteration), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                      end
                      
                      iteration.item :show, I18n.t('general.details'), "#{scholarship_iteration_path(@iteration)}#top"
                      iteration.item :edit, I18n.t('general.edit'), edit_scholarship_iteration_path(@iteration) if can? :edit, @iteration
                      iteration.item :participants, I18n.t('scholarship_iteration_participations.index.title'), scholarship_iteration_participants_path(@iteration) do |team_members|
                        team_members.item(
                          :new, I18n.t('scholarship_iteration_participations.new.title'), new_scholarship_iteration_participant_path(@iteration), 
                          highlights_on: -> { params[:controller] == 'scholarship/iteration_participations' && ['new', 'create'].include?(params[:action]) }
                        )
                        
                        unless (@iteration_participation.new_record? rescue true)
                          team_members.item(
                            :edit, I18n.t('scholarship_iteration_participations.edit.title'), edit_scholarship_iteration_participation_path(@iteration_participation),
                            highlights_on: -> { params[:controller] == 'scholarship/iteration_participations' && ['edit', 'update'].include?(params[:action]) }
                          )
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          
          primary.item :scholarship_teams, I18n.t('scholarship_teams.index.short_title'), scholarship_teams_path do |teams|
            teams.item :new, I18n.t('general.new'), new_scholarship_team_path
            
            unless (@team.new_record? rescue true)
              teams.item :show, @team.name, scholarship_team_path(@team) do |team|
                if can? :destroy, @team
                  team.item :destroy, I18n.t('general.destroy'), scholarship_team_path(@team), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                end
      
                team.item :show, I18n.t('general.details'), "#{scholarship_team_path(@team)}#top"
                team.item :edit, I18n.t('general.edit'), edit_scholarship_team_path(@team) if can? :edit, @team
                team.item :members, I18n.t('scholarship_team_memberships.index.title'), scholarship_team_members_path(@team) do |team_members|
                  team_members.item(
                    :new, I18n.t('scholarship_team_memberships.new.title'), new_scholarship_team_member_path(@team), 
                    highlights_on: -> { params[:controller] == 'scholarship/team_memberships' && ['new', 'create'].include?(params[:action]) }
                  )
                  
                  unless (@team_membership.new_record? rescue true)
                    team_members.item(
                      :edit, I18n.t('scholarship_team_memberships.edit.title'), edit_scholarship_team_membership_path(@team_membership),
                      highlights_on: -> { params[:controller] == 'scholarship/team_memberships' && ['edit', 'update'].include?(params[:action]) }
                    )
                  end
                end
              end
            end
          end
          
          if user_signed_in?
            primary.item :workflow, I18n.t('workflow.index.title'), scholarship_workflow_path do |workflow|
              workflow.item :organization_owner, I18n.t('products.scholarship.workflow.organization_owner.index.title'), scholarship_workflow_organization_owner_index_path
              workflow.item :team_leader, I18n.t('products.scholarship.workflow.team_leader.index.title'), scholarship_workflow_team_leader_index_path
            end
          end
          
          instance_exec primary, ::Voluntary::Navigation::Base.menu_options(:authentication), &::Voluntary::Navigation.menu_code(:authentication)
        end
      end
    end
  end
end
    