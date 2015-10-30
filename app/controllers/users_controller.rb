class UsersController < ApplicationController

  before_action :authenticate_user!

  def get_my_posts
    @post = Post.all
    render 'index'
  end

end
