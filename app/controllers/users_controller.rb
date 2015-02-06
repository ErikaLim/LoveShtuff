class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
    @foursquare = []
    response = RestClient.get('https://api.foursquare.com/v2/users/self/checkins?oauth_token=2TIM1DJ1POSQC2T3SF01YA2XX4GBPDFWT5YRTFZA40PYBNJ4&v=20150205')
    @checkins_hash = JSON.parse(response.body)["response"]["checkins"]["items"]
    @checkins_hash.each do |c|
      puts c["venue"]["name"]
    end
      # puts url
      # begin
      #   data = RestClient.get(url)
      #   res = JSON.parse(data.body)
      #   res.each do |foursquare|
      #     @foursquare << foursquare["items"]

        # end
      # rescue => e
      #   puts e.response
      # end

    # end
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
