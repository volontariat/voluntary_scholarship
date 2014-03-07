class Scholarship::ProgramsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  respond_to :html, :js, :json
  
  def index
    @parent = find_parent Scholarship::Program::PARENT_TYPES
    @programs = @parent ? @parent.scholarship_programs.order(:name) : Scholarship::Program.order(:name)
    
    respond_to do |format|
      format.html
      format.json { render json: @programs.tokens(params[:q]) }
    end
  end
  
  def show
    @comments = @program.comments
  end
  
  def new
    @parent = find_parent Scholarship::Program::PARENT_TYPES
    @program = @parent ? @parent.scholarship_programs.new : Scholarship::Program.new
  end
  
  def create
    @program = Scholarship::Program.new(params[:scholarship_program])
    
    if @program.save
      redirect_to @program, notice: t('general.form.successfully_created')
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @program.update_attributes(params[:scholarship_program])
      redirect_to @program, notice: t('general.form.successfully_updated')
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    redirect_to organization_scholarship_programs_path(@program.organization), notice: t('general.form.destroyed')
  end
  
  def resource
    @program
  end
  
  private
  
  def not_found
    redirect_to scholarship_programs_path, notice: t('programs.exceptions.not_found')
  end
end