class Scholarship::Workflow::OrganizationOwnerController < ApplicationController
  include ::Scholarship::BaseController
  
  before_filter :authenticate_user!
  
  def index
    @iteration_participations = Scholarship::IterationParticipation.of_organization_owner(current_user).requested.
    order_by_user_full_name.includes(iteration: { program: :organization}).paginate(page: params[:page], per_page: 25) 
  end
end