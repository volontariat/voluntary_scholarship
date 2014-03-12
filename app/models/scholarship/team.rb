module Scholarship
  class Team < ActiveRecord::Base
    KINDS = %w(sponsored voluntary)
    
    self.table_name = 'scholarship_teams'
    
    include Applicat::Mvc::Model::Resource::Base
    
    has_many :memberships, class_name: 'Scholarship::TeamMembership'
    has_many :members, class_name: 'User', through: :memberships
    
    validates :name, presence: true, uniqueness: true
    validates :kind, presence: true, inclusion: { in: KINDS }
    
    attr_accessible :name, :text, :kind, :github_handle, :twitter_handle
    
    attr_accessor :leader
    
    after_create :create_team_leader_membership
    
    extend FriendlyId
    friendly_id :name, use: :slugged
    
    private
    
    def create_team_leader_membership
      membership = memberships.new(roles: [:team_leader])
      membership.user_id = leader.try(:id)
      membership.save!
    end
  end
end