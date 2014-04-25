class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

	def show
  	@user = User.find(params[:id])
  	@posts = @user.posts
  end

  def create
    @user = User.create( user_params )
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
  params.require(:user).permit(:name, :location, :avatar)
  end
end