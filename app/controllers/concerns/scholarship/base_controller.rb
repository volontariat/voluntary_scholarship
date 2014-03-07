module Scholarship
  module BaseController
    extend ActiveSupport::Concern
      
    def application_navigation
      :main_scholarship
    end
    
    def navigation_product_path
      scholarship_product_path
    end
    
    def navigation_product_name
      'Scholarship'
    end
  end
end