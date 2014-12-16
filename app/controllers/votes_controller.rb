class VotesController < ApplicationController	

  def create
    @vote = @vote.new
    @vote.user_id = session[:user_id]
    if @vote.save
      flash[:success] = "Vote created!"
    else
      @feed_items = []
	    end
  end

  private

    def vote_params
      params.require(:user_id).permit(:isUpvote)
    end
    
    def correct_user
      @post = Post.find(session[:current_post_id])
      @comment = @post.comments.find_by(id: params[:id])
      redirect_to @post if @comment.nil?
    end
  end
