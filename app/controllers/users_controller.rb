class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

	def show
  	@user = User.find(params[:id])
  	@posts = @user.posts.order("created_at DESC")
  end

  def create
    @user = User.create( user_params )
  end

  def edit
  end

  def update
    @user.update_without_password(devise_parameter_sanitizer.sanitize(:account_update))
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

end