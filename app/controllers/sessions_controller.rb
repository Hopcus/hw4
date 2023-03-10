class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by({ "email" => params["email"] })
    if @user
      if BCrypt::Password.new(@user["password"]) == params["password"]
        session["user_id"] = @user["id"]
        flash["notice"] = "Hello, welcome back to your travel journal."
        redirect_to "/places"
      else
        flash["notice"] = "Incorrect password, please try again."
        redirect_to "/sessions/new"
      end
    else
      flash["notice"] = "There is no account associated with that email."
      redirect_to "/sessions/new"
    end
  end

  def destroy
    session["user_id"] = nil
    flash["notice"] = "Goodbye."
    redirect_to "/sessions/new"
  end
end
  