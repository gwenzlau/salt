class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def show
  	@user = User.find(params[:id])
  	@posts = @user.posts
  end

  def create
    # Create the user from params
    @user = User.new(params[:user])
    if @user.save
      # Deliver the signup email
      Notifier.send_signup_email(@user).deliver
      redirect_to(@user, :notice => 'Welcome!')
    else
      render :action => 'index'
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'Account was successfully updated.'
    else
      render action: 'edit'
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
  params.require(:user).permit(:name, :location)
  end
end