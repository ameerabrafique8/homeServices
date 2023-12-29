class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def dashboard
    @user = current_user
    @users = User.all
    # @services = @user.services
    @services = Service.all
    @bookings = @user.bookings
  end

  def show
    @dashboard_data = retrieve_dashboard_data
    # Your existing dashboard action logic...
  end

  private

  def retrieve_dashboard_data
    session[:dashboard_data]
  end
end
