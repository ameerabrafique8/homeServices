class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_service, only: [:show]

  def index
    @services = Service.all
  end

  def new
    @service = current_user.services.build
    authorize @service

    #or you can do it like this  @service =  Service.new(user:current_user)
  end

  def create
    @service = current_user.services.build(service_params)
    authorize @service

    if @service.save
      redirect_to services_path, notice: 'Service created Successfully!'
    else
      render :new
    end
  end

  def show
    @service
  end

  private

  def service_params
    params.require(:service).permit(:name, :description, :status, :average_rating, :price)
  end

  def set_service
    @service = Service.find(params[:id])
  end

end
