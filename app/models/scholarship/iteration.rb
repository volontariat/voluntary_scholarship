module Scholarship
  class Iteration < ActiveRecord::Base
    self.table_name = 'scholarship_iterations'
    
    include Applicat::Mvc::Model::Resource::Base
    
    belongs_to :program, class_name: 'Scholarship::Program'
    
    has_many :participations, class_name: 'Scholarship::IterationParticipation'
    has_many :participants, class_name: 'User', through: :participations
    
    validates :program_id, presence: true, uniqueness: { scope: [:from, :to] }
    validates :from, presence: true
    validates :to, presence: true
    validate :to_must_be_greater_than_from
    
    attr_accessible :name, :program_id, :from, :to
    
    PARENT_TYPES = ['scholarship_program']
    
    def to_s
      name.present? ? name : "#{program.name} #{from.strftime('%d.%m.%Y')} - #{to.strftime('%d.%m.%Y')}"
    end
    
    private
    
    def to_must_be_greater_than_from
      if from > to
        errors.add(
          :to,
          I18n.t('activerecord.errors.models.scholarship_iteration.attributes.to.to_must_be_greater_than_from')
        )
      end
    end
  end
end