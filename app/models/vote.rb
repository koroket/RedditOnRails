class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :isUpvote, presence: true
end
