class Comment < ActiveRecord::Base
  validates :thoughts, presence: true
  belongs_to :post
  belongs_to :user
end
