module VoluntaryScholarship
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../../../app/models/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/controllers/concerns", __FILE__)
    config.autoload_paths << File.expand_path("../..", __FILE__)
    
    SimpleNavigation::config_file_paths << File.expand_path("../../../config", __FILE__)
  end
end
