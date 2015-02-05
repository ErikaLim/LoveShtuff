class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to @user, notice: 'User was successfully created.'
    else
      render:new
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      render:edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
      redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password_digest
    )
  end
end
