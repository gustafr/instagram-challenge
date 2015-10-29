module PostsHelper

  def get_like_id(post, user)
    post.find_like(user)
  end

  def get_hours_since_posted(post)
    post.hours_since_posted
  end

end
