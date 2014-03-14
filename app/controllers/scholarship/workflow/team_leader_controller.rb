class Scholarship::Workflow::TeamLeaderController < ApplicationController
  include ::Scholarship::BaseController
  
  before_filter :authenticate_user!
  
  def index
    @team_memberships = Scholarship::TeamMembership.of_team_leader(current_user).requested.
    order_by_user_full_name.includes(:team).paginate(page: params[:page], per_page: 25) 
  end
end