class UsersController < ApplicationController
  before_action :authenticate_user!
  def profile
  end

  def edit
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to profile_path
  end

  def show
  end

  def admin_dashboard
  end 

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :address, :city, :zipcode, :state, :phone)
  end


end
