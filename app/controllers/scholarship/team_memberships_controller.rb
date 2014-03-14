class Scholarship::TeamMembershipsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  include VoluntaryScholarship::TeamMembershipsHelper
  
  transition_actions Scholarship::TeamMembership::EVENTS
  
  before_filter :find_team_membership, only: [:new]
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    @team = Scholarship::Team.friendly.find(params[:team_id])
    @team_memberships = @team.memberships.accepted.order_by_user_full_name.paginate(page: params[:page], per_page: 25)
  end
  
  def new
  end
  
  def create
    @team_membership = Scholarship::TeamMembership.new(params[:scholarship_team_membership])
    @team_membership.user = current_user
    @team = @team_membership.team
    
    if @team_membership.save
      redirect_to scholarship_team_members_path(@team_membership.team), notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if params[:scholarship_team_membership][:roles].present? && !can_update_scholarship_team_membership_roles?(@team_membership)
      raise CanCan::AccessDenied  
    end
    
    if @team_membership.update_attributes(params[:scholarship_team_membership])
      redirect_to [:edit, @team_membership], notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @team_membership.destroy
    redirect_to scholarship_team_members_path(@team_membership.team), notice: t('general.form.destroyed')
  end
  
  def resource
    @team_membership
  end
  
  def with_state
    @team_memberships = Scholarship::TeamMembership.of_team_leader(current_user).send(params[:state]).
    order_by_user_full_name.includes(:team).paginate(page: params[:page], per_page: 25) 
    render layout: false
  end
  
  private
  
  def find_team_membership
    @team_membership = case action_name
    when 'new'
      @team = Scholarship::Team.friendly.find(params[:team_id])
      @team.memberships.new
    end
  end
  
  def not_found
    redirect_to root_path, notice: t('general.exceptions.not_found')
  end
end