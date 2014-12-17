class PostsController < ApplicationController

  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
    session[:current_post_id] = params[:id]
  end

  def new
  	if logged_in?
	    @post = current_user.posts.build 
	  else
	  	redirect_to login_url
	  end	
  end

  def create
    @post = current_user.posts.build(post_params)

    subreddits = Subreddit.where(subname: @post.subname)
    if subreddits.first
      @post.subreddit_id = subreddits.first.id
      if @post.save
      flash[:success] = "Post created!"
      redirect_to posts_url
      else
        @feed_items = []
          render 'new'
      end
    else
      render 'new'
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post deleted"
    redirect_to request.referrer || root_url
    # TODO: redirect causes error if you delete from posts/post_id
  end

#VOTES
  def upvote
    if current_user_existing_vote.nil?
      @post = Post.find(params[:id])
      @vote = @post.votes.create
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
      @post = Post.find(params[:id])
      @vote = @post.votes.create
      @vote.update_attributes(isUpvote: false, user_id: current_user.id)
      redirect_to request.referrer
    else
      current_user_existing_vote.update_attribute(:isUpvote, false)
      redirect_to request.referrer
    end  
  end

  private

    def post_params
      params.require(:post).permit(:title, :link, :body, :subname)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end

    def current_user_existing_vote
      @vote = current_user.votes.find_by(post_id: params[:id])
    end
end
