class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!


  def index
    @posts = Post.all.order("created_at DESC")
    @open_missions = Post.where(:status => "0").order("created_at DESC")
    @ip_missions = Post.where(:status => "1").order("created_at DESC")
    @acc_missions = Post.where(:status => "2").order("created_at DESC")
    @status = current_user.posts.where(:post_id => params[:id])
  end

  def show
    @post = Post.find(params[:id])
    if signed_in?
      @user = current_user
    end
  end

  def new
    @post = current_user.posts.build
  end

  def edit
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: 'Post was successfully created.'
    else
      render action: 'new'
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: 'Post was successfully updated.'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_url
  end

  def vote
    @post = Post.find(params[:id])
    @post.liked_by current_user
    redirect_to :back, notice: "Thanks, SlyFox. We will be in touch."
  end

  def open_mission
    @posts = current_user.posts.where(status: "0")
  end

  def ip_mission
    @post.activity key: 'post.ip_mission'
    if @post.update_attribute(:status, "1")
      redirect_to @post, :notice => "Mission In Progress"
    else
      redirect_to @post, :notice => "An error occured while changing the mission status."
    end
  end

  def acc_mission
    @post.activity key: 'post.acc_mission'
    if @post.update_attribute(:status, "2")
      redirect_to @post, :notice => "Mission Accomplished"
    else
     redirect_to @post,  :notice => "An error occured while changing the mission status."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def correct_user
    	@post = current_user.posts.find_by(id: params[:id])
    	redirect_to posts_path, notice: "Not authorized to edit this post" if @post.nil?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:description, :location, :details, :deadline, :status)
    end
end
