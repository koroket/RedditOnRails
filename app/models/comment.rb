class Comment < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :comment
  belongs_to :post
  belongs_to :user
  default_scope -> { order(created_at: :asc) }
  validates :user_id, presence: true
  validates :content, presence: true
end
