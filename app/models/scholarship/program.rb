module Scholarship
  class Program < ActiveRecord::Base
    self.table_name = 'scholarship_programs'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :organization

    has_many :iterations, class_name: 'Scholarship::Iteration', dependent: :destroy
    
    validates :organization_id, presence: true
    validates :name, presence: true, uniqueness: { scope: [:organization_id] }
    
    attr_accessible :name, :text, :organization_id
    
    PARENT_TYPES = ['organization']
  end
end