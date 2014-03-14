require 'spec_helper'

describe Scholarship::IterationParticipationsController do
  describe 'update' do
    context 'roles passed and is not allowed to update iteration participation roles' do
      it 'raises access denied' do
        iteration_participation = FactoryGirl.create(:scholarship_iteration_participation)
        
        post :update, _method: 'patch', id: iteration_participation.id, scholarship_iteration_participation: { roles: [:student] }
        
        flash.alert.should include('Access denied')
      end
    end
  end
end