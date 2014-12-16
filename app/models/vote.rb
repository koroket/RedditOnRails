class Vote < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  belongs_to :comment
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
end
