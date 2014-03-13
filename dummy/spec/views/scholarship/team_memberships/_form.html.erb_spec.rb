require 'spec_helper'

describe 'scholarship/team_memberships/_form.html.erb' do
  before :each do
    @membership = FactoryGirl.create(:scholarship_team_membership)
    assign(:membership, @membership)
  end
  
  describe 'roles field' do
    context 'user can update scholarship team membership roles' do
      it 'shows the field' do
        view.stub!(:can_update_scholarship_membership_roles?).with(@membership).and_return(true)
        
        render
        
        rendered.match(/scholarship_team_membership\[roles\]\[\]/).should_not be_nil
      end
    end
    
    context 'user cannot update scholarship team membership roles' do
      it 'shows a list of roles instead of the field' do
        view.stub!(:can_update_scholarship_membership_roles?).with(@membership).and_return(false)
        
        render
        
        rendered.match(/scholarship_team_membership\[roles\]\[\]/).should be_nil
        rendered.match('<div class="controls">Student</div>').should_not be_nil
      end
    end
  end
end
