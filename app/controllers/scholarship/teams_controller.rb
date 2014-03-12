class Scholarship::TeamsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  
  before_filter :find_team, only: [:show, :edit, :update, :destroy]  
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    @teams = Scholarship::Team.order(:name)
    @teams = @teams.paginate(page: params[:page], per_page: 25)
  end
  
  def show
  end
  
  def new
    @team = Scholarship::Team.new#(kind: 'sponsored')
  end
  
  def create
    @team = Scholarship::Team.new(params[:scholarship_team])
    @team.leader = current_user
    
    if @team.save
      redirect_to @team, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @team.update_attributes(params[:scholarship_team])
      redirect_to @team, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @team.destroy
    redirect_to scholarship_teams_path, notice: t('general.form.destroyed')
  end
  
  def resource
    @team
  end
  
  private
  
  def find_team
    @team = Scholarship::Team.friendly.find(params[:id])
  end
  
  def not_found
    redirect_to scholarship_teams_path, notice: t('general.exceptions.not_found')
  end
end