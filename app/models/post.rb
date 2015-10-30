class Post < ActiveRecord::Base

  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }

  validates :content, presence: true
  validates :image, attachment_presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes
  validates_attachment_file_name :image, matches: [/gif\Z/, /png\Z/, /jpe?g\Z/]

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  belongs_to :user

  def find_like(user)
    likes.where(user_id: user.id).first.id
  end

  def hours_since_posted
    time_created = created_at.to_i
    time_now = Time.now.to_i
    hours_since_post = (time_now - time_created) / 3600
    hours_since_post
  end

end

