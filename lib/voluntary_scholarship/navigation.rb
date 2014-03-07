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
          
          primary.item :programs, I18n.t('scholarship_programs.index.title'), scholarship_programs_path do |programs|
            programs.item :new, I18n.t('general.new'), new_scholarship_program_path
            
            unless (@program.new_record? rescue true)
              programs.item :show, @program.name, scholarship_program_path(@program) do |program|
                if can? :destroy, @program
                  program.item :destroy, I18n.t('general.destroy'), scholarship_program_path(@program), method: :delete, confirm: I18n.t('general.questions.are_you_sure')
                end
                
                program.item :show, I18n.t('general.details'), "#{scholarship_program_path(@program)}#top"
                program.item :edit, I18n.t('general.edit'), edit_scholarship_program_path(@program) if can? :edit, @program
              end
            end
          end
        end
      end
    end
  end
end
    