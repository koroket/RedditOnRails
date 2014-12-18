module PostsHelper
	def update_sort_scores
		@posts = Post.all
		@posts.each do |post|
			post.update_sort_score
		end
	end
end
