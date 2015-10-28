class LikesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

  def create
    @post = Post.find(params[:post_id])
    like = @post.likes.create(likes_params)
    redirect_to posts_path
  end

  def like_params
    params.require(:like).permit(:status)
  end

end
