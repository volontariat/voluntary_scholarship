module VoluntaryScholarship
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../../../app/models/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/controllers/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../..", __FILE__)
    config.i18n.load_path += Dir[File.expand_path("../../../config/locales/**/*.{rb,yml}", __FILE__)]
    
    SimpleNavigation::config_file_paths << File.expand_path("../../../config", __FILE__)
    
    config.to_prepare do
      Organization.send :include, ::VoluntaryScholarship::Concerns::Model::HasScholarshipPrograms
      
      ::Ability.add_after_initialize_callback(VoluntaryScholarship::Ability.after_initialize)
      
      VoluntaryScholarship::Navigation.voluntary_menu_customization
    end
  end
end
