module PostsHelper

  def get_like_id(post, user)
    post.find_like(user)
  end
end
