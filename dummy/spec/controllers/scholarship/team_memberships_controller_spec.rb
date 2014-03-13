require 'spec_helper'

describe Scholarship::TeamMembershipsController do
  describe 'update' do
    context 'roles passed and is not allowed to update membership roles' do
      it 'raises access denied' do
        team_membership = FactoryGirl.create(:scholarship_team_membership)
        
        post :update, _method: 'patch', id: team_membership.id, scholarship_team_membership: { roles: [:team_leader] }
        
        flash.alert.should include('Access denied')
      end
    end
  end
end