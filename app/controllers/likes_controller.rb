class LikesController < ApplicationController

  def new
    @post = Post.find(params[:post_id])
    @like = Like.new
  end

end
