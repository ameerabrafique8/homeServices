class ServicesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_service_creation, only: [:new, :create]

  def index
    @services = Service.all
  end

  def new
    @service = current_user.services.build
    #or you can do it like this  @service =  Service.new(user:current_user)
  end

  def create
    @service = current_user.services.build(service_params)

    if @service.save
      redirect_to services_path, notice: 'Service created Successfully!'
    else
      render :new
    end
  end

  def show
    @service = Service.find(params[:id])
  end

  private

  def service_params
    params.require(:service).permit(:name, :description)
  end

  def authorize_service_creation
    authorize Service
  end
end
