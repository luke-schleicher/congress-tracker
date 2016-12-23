class UsersController < ApplicationController

  def create
    @user = User.new(whitelisted_params)
    if @user.save
      @user.assign_legislators(session[:reps])
      User.delay.welcome_email(@user.id)
      User.delay.weekly_email(@user.id)
      flash[:success] = "Email successfully added! Check your inbox each week for updates."
      redirect_back(fallback_location: legislators_path)
    else
      flash[:warning] = "We were unable to add your email to our mailing list."
      redirect_back(fallback_location: legislators_path)
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:success] = "We've removed your email from the subscriber list"
      redirect_to root_path
    else
      flash[:error] = "No email address found"
      redirect_to root_path
    end
  end

  private

  def whitelisted_params
    params.require(:user).permit(:email)
  end

end
