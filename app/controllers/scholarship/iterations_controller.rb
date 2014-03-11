class Scholarship::IterationsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  
  before_filter :find_iteration, only: [:new]
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @program = Scholarship::Program.find(params[:program_id])
    @iterations = @program.iterations.order('scholarship_iterations.from DESC') 
    
    respond_to do |format|
      format.html
      format.json { render json: @iterations.tokens(params[:q]) }
    end
  end
  
  def show
    @program = @iteration.program
  end
  
  def new
  end
  
  def create
    @iteration = Scholarship::Iteration.new(params[:scholarship_iteration])
    
    if @iteration.save
      redirect_to @iteration, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @iteration.update_attributes(params[:scholarship_iteration])
      redirect_to @iteration, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @iteration.destroy
    redirect_to scholarship_program_iterations_path(@iteration.program), notice: t('general.form.destroyed')
  end
  
  def resource
    @iteration
  end
  
  private
  
  def find_iteration
    @iteration = case action_name
    when 'new'
      @program = Scholarship::Program.find(params[:program_id])
      @program.iterations.new
    end
  end
  
  def not_found
    redirect_to root_path, notice: t('general.exceptions.not_found')
  end
end