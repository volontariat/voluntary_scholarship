module VoluntaryScholarship
  module Concerns
    module Model
      module HasScholarshipPrograms
        extend ActiveSupport::Concern
        
        included do
          has_many :scholarship_programs, class_name: 'Scholarship::Program', dependent: :destroy
        end
      end
    end
  end
end