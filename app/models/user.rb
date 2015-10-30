class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  def my_posts
    posts.all
  end

  def is_post_owner?(post)
    posts.include?(post)
  end

  def is_likes_owner?(like)
    likes.include?(like)
  end

  def has_liked?(post)
    likes.any? do |like|
      like.post_id == (post.id)
    end
  end

end
