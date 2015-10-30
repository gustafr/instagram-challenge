class Like < ActiveRecord::Base

  validates :status, presence: true

  belongs_to :post
  belongs_to :user

end
