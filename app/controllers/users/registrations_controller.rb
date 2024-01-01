# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  def index
    @users = User.all
  end

  # POST /resource
  # def create
    def create
    @user = User.new(user_params)

    if @user.save
      dashboard_data = @user.initialize_dashboard_data
      store_dashboard_data(dashboard_data) # Store data in the session
      flash[:notice] = "Welcome, #{@user.name}!"
      store_dashboard_data(dashboard_data)
      @dashboard_data = dashboard_data
      redirect_to user_dashboard_path
      # redirect_to user_dashboard_path(@user)
    else
      flash[:alert] = "User creation failed. Please check the form."
      render :new
    end
  end
  # end

  def destroy
    # Sign out the current user
    sign_out(current_user)
    flash[:notice] = "Successfully signed out."
    redirect_to root_path
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :gender, :role, :email, :password, :password_confirmation)
    .merge(gender: params[:user][:gender].to_i,role: params[:user][:role].to_i)
  end

  def dashboards_controller
    @dashboards_controller ||= DashboardsController.new
  end

  def store_dashboard_data(data)
    session[:dashboard_data] = data
  end


  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end
end
