class Scholarship::IterationParticipationsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  include VoluntaryScholarship::IterationParticipationsHelper
  
  transition_actions Scholarship::IterationParticipation::EVENTS
  
  before_filter :find_iteration_participation, only: [:new]
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    @iteration = Scholarship::Iteration.find(params[:iteration_id])
    @program = @iteration.program
    @iteration_participations = @iteration.participations.accepted.order_by_user_full_name.paginate(page: params[:page], per_page: 25)
  end
  
  def new
  end
  
  def create
    @iteration_participation = Scholarship::IterationParticipation.new(params[:scholarship_iteration_participation])
    @iteration_participation.user = current_user
    @iteration = @iteration_participation.iteration
    @program = @iteration.program
    
    if @iteration_participation.save
      redirect_to scholarship_iteration_participants_path(@iteration_participation.iteration), notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if params[:scholarship_iteration_participation][:roles].present? && !can_update_scholarship_iteration_participation_roles?(@iteration_participation)
      raise CanCan::AccessDenied  
    end
    
    if @iteration_participation.update_attributes(params[:scholarship_iteration_participation])
      redirect_to [:edit, @iteration_participation], notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @iteration_participation.destroy
    redirect_to scholarship_iteration_participants_path(@iteration_participation.iteration), notice: t('general.form.destroyed')
  end
  
  def resource
    @iteration_participation
  end
  
  def with_state
    @iteration_participations = Scholarship::IterationParticipation.of_organization_owner(current_user).send(params[:state]).
    order_by_user_full_name.includes(iteration: { program: :organization}).paginate(page: params[:page], per_page: 25) 
    render layout: false
  end
  
  private
  
  def find_iteration_participation
    @iteration_participation = case action_name
    when 'new'
      @iteration = Scholarship::Iteration.find(params[:iteration_id])
      @program = @iteration.program
      @iteration.participations.new
    end
  end
  
  def not_found
    redirect_to root_path, notice: t('general.exceptions.not_found')
  end
end