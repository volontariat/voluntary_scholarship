class Scholarship::ProgramsController < ApplicationController
  include ::Scholarship::BaseController
  include Applicat::Mvc::Controller::Resource
  
  before_filter :find_program, only: [:new]  
  
  load_and_authorize_resource
  
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
  def index
    @organization = find_parent Scholarship::Program::PARENT_TYPES
    @programs = @organization ? @organization.scholarship_programs.order(:name) : Scholarship::Program.order(:name)
    @programs = @programs.paginate(page: params[:page], per_page: 25)
  end
  
  def show
  end
  
  def new
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
  
  def find_program
    @program = case action_name
    when 'new' then 
      @organization = Organization.friendly.find(params[:organization_id]) if params[:organization_id].present?
      @organization.present? ? @organization.scholarship_programs.new : Scholarship::Program.new
    end
  end
  
  def not_found
    redirect_to scholarship_programs_path, notice: t('general.exceptions.not_found')
  end
end