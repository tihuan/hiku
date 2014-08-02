class SessionsController < ApplicationController

  def create
    user = User.authenticate(params)
    if user[:status] == "ok"
      session[:token] = user[:data][:token]
      head 200
    else
      render json: user[:errMsg] , status: 401
    end
  end

  def destroy
    session[:token] = nil
    render json: 'Logged out successfully.'
  end
end
