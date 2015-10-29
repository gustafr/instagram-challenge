class LikesController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    if current_user == true && current_user.has_liked?(@post) == true
      flash[:notice] = 'You have already liked thos post'
      render posts_path
    else
      like = @post.likes.create(status: params.permit)
      like.update_attribute(:user, current_user)
      redirect_to posts_path
    end
    # respond_to do |format|
    #   format.html { redirect_to posts_path }
    #   format.js { redirect_to posts_path }
  end


  def show
    @post = Post.find(params[:id])
    @like = Like.find(params[:id])
  end


  def destroy
    @like = Like.find(params[:id])
    if current_user.is_likes_owner? @like
      @like.destroy
      flash[:notice] = 'Like deleted successfully!'
      redirect_to posts_path
    else
      flash[:alert] = 'You are not the owner of this like!'
      redirect_to posts_path
    end
  end

  def like_params
    params.permit(:status)
  end
end
