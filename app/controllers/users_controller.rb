class UsersController < ApplicationController

  def index
    @users = User.where(activated: true)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts
    redirect_to root_url and return unless @user.activated
  end

  def new
    @user = User.new
  end
  
  def create

    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render 'new'
    end
  end

    # Activates an account.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end

  # Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now

  end
  
  private
  
  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

end