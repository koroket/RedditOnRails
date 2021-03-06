class SubnameValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless !!Subreddit.where(subname: value).first
      record.errors[attribute] << (options[:message] || "Subreddit does not exist")
    end
  end
end

class Post < ActiveRecord::Base
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :votes, as: :votable, dependent: :destroy
  belongs_to :user
  belongs_to :subreddit
  default_scope -> { order(sort_score: :desc) }
  validates :user_id, presence: true
  validates :body, presence: true
  validates :subreddit_id, presence: true
  validates :subname, subname: true

  def update_sort_score
  	upvotes = self.votes.where(isUpvote: true).count
  	downvotes = self.votes.where(isUpvote: false).count
  	votes = upvotes - downvotes
  	age = Time.diff(Time.now, self.created_at)[:hour]
  	gravity = 1.8
  	new_score = (votes - 1) / (age + 2) ** gravity
		self.update_attribute(:sort_score, new_score)
  end

end
