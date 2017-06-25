class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_admin!

  def index
    @users = User.all
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to users_path
      flash[:success] = "User updated"
    else
      redirect_to users_path
      flash[:danger] = "Unable to update user"
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
    flash[:success] = "User removed"
  end

  private

  def user_params
    params.require(:user).permit(:admin)
  end
end
