class Subreddit < ActiveRecord::Base
	  has_many :posts, dependent: :destroy
	  validates :subname, uniqueness:{ message: "already taken"}
end
