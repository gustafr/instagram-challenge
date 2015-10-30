class PostsController < ApplicationController

  before_action :authenticate_user!, :except => [:index, :show]

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    @post.update_attribute(:user, current_user)
    if @post.save == true
      redirect_to posts_path
    else
      render 'new'
    end
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
    unless current_user.is_post_owner? @post
      flash[:alert] = 'You are not the owner of this post!'
      render 'show'
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    if @post.save
      flash[:notice] = 'Post updated successfully!'
      redirect_to posts_path
    else
      render 'edit'
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if current_user.is_post_owner? @post
      @post.destroy
      flash[:notice] = 'Post deleted successfully!'
      redirect_to posts_path
    else
      flash[:alert] = 'You are not the owner of this post!'
      render 'show'
    end
  end

  def post_params
    params.require(:post).permit(:title, :content, :image)
  end

end
