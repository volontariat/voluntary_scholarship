module Scholarship
  class Program < ActiveRecord::Base
    self.table_name = 'scholarship_programs'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :organization
    
    has_many :comments, as: :commentable, dependent: :destroy
    
    validates :organization_id, presence: true
    validates :name, presence: true, uniqueness: true
    
    attr_accessible :name, :organization_id
    
    PARENT_TYPES = ['organization']
  end
end