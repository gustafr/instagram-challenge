class UsersController < ApplicationController

  before_action :authenticate_user!

  def get_my_posts
    @posts = current_user.my_posts
    render 'index'
  end

end
