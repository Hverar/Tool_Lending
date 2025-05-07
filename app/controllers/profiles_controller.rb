class ProfilesController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
  end

  def destroy
    @user = User.find(params[:id])
    if @user == current_user
      @user.destroy
      redirect_to users_path, notice: "User profile was successfully deleted."
    else
      redirect_to users_path, alert: "You are not authorized to delete this profile photo."
    end
  end
end
