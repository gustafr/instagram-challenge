class Comment < ActiveRecord::Base

  validates :thoughts, presence: true

  belongs_to :post
  belongs_to :user

  def hours_since_posted
    time_created = created_at.to_i
    time_now = Time.now.to_i
    hours_since_post = (time_now - time_created) / 3600
    hours_since_post
  end

end
