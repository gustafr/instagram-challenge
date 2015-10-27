class Post < ActiveRecord::Base
  has_attached_file :image, styles: { large: "600x600>", medium: "300x300>", thumb: "150x150#" }
  validates :title, presence: true
  validates :content, presence: true
  validates :image, attachment_presence: true
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
  validates_with AttachmentSizeValidator, attributes: :image, less_than: 4.megabytes
  validates_attachment_file_name :image, matches: [/gif\Z/, /png\Z/, /jpe?g\Z/]
  has_many :comments, dependent: :destroy
  belongs_to :user

end
