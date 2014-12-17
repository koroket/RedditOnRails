class CommentsController < ApplicationController
	  before_action :logged_in_user, only: [:create, :destroy]

  # def index
  #   @posts = Post.all
  # end

  # def show
  #   @comment = Comment.find(params[:id])
  # end

  def new
  	@comment = Comment.new(parent_id: params[:parent_id])

  	respond_to do |format|
  	 format.html
  	 format.js
  	end
  end

  def create
  	@post = Post.find(session[:current_post_id])

  	if params[:parent_id].to_i > 0
    parent = Comment.find_by_id(params[:parent_id])
    @comment = parent.comments.build(comment_params)
    @comment.user_id = session[:user_id]
    else
    @comment = @post.comments.build(comment_params)
    @comment.user_id = session[:user_id]
    end

    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to @post
    else
      @feed_items = []
				redirect_to login_url
	    end
  end

  def destroy
  	@post = Post.find(session[:current_post_id])
  	@comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment deleted"
    redirect_to @post
  end

# VOTES
  def upvote
    if current_user_existing_vote.nil?
      @comment = Comment.find(params[:id])
      @vote = @comment.votes.create
      @vote.update_attributes(isUpvote: true, user_id: current_user.id)
      redirect_to request.referrer
    else
      current_user_existing_vote.update_attribute(:isUpvote, true)
      redirect_to request.referrer
    end
  end

  def unvote
    if current_user_existing_vote.nil?
      redirect_to request.referrer
    else
      current_user_existing_vote.destroy
      redirect_to request.referrer
    end
  end

  def downvote
    if current_user_existing_vote.nil?
      @comment = Comment.find(params[:id])
      @vote = @comment.votes.create
      @vote.update_attributes(isUpvote: false, user_id: current_user.id)
      redirect_to request.referrer
    else
      current_user_existing_vote.update_attribute(:isUpvote, false)
      redirect_to request.referrer
    end  
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def current_user_existing_vote
      @vote = current_user.votes.find_by(comment_id: params[:id])
    end
end
