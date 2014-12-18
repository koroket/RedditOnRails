class SubredditsController < ApplicationController
  def show
  	@subname = params[:subname]
  	subreddits = Subreddit.where(subname: params[:subname])
  	if subreddits.first
  	    @posts = subreddits.first.posts
  	else
  		render 'new'
  	end

  end

  def new
  	@subreddit = Subreddit.new
  end

  def create
  	@subreddit = Subreddit.new(subreddit_params)

      if @subreddit.save
      redirect_to root_url
      else
      render 'new'

      end
  end

  private

  def subreddit_params
    params.require(:subreddit).permit(:subname)
  end
end