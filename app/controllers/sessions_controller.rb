# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  def new

  end
  def create
    if login(params[:email],params[:password])
      redirect_to root_path
    else
      render :new
    end
  end
  def destroy
    logout
    redirect_to login_path
  end
end
