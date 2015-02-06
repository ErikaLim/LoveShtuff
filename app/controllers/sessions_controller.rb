class SessionsController < ApplicationController
  def new

  end

  def create
    auth_hash = request.env['omniauth.auth']

    @authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"])
    if @authorization
      render :text => "Welcome back #{@authorization.user.name}! You have already signed up."
    else
      user = User.new :first_name => auth_hash["info"]["first_name"], :email => auth_hash["info"]["email"]
      user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
      user.save

      redirect_to root_path
    end
  end

  def failure

  end

  def index
    @foursquare = []
    response = RestClient.get('https://api.foursquare.com/v2/users/self/checkins?oauth_token=2TIM1DJ1POSQC2T3SF01YA2XX4GBPDFWT5YRTFZA40PYBNJ4&v=20150205')
    @checkins_hash = JSON.parse(response.body)["response"]["checkins"]["items"]
    @checkins_hash.each do |c|
      puts c["venue"]["name"]
    end
  end

  def destroy
    session[:user_id] = nil
    render :text => "You've logged out!"
  end

end
