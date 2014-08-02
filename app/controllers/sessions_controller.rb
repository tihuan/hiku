class SessionsController < ApplicationController

  def create
    if user = User.authenticate(params)
      session[:token] = user[:token]
      render json: user,  status: 200
    else
      render json: 'Invalid inputs. Please try again!'
    end
  end

  def destroy
    session[:token] = nil
    render json: 'Logged out successfully.'
  end
end
