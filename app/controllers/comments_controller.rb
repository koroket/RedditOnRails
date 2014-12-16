class CommentsController < ApplicationController
	  before_action :logged_in_user, only: [:create, :destroy]
	  before_action :correct_user,   only: :destroy

  # def index
  #   @posts = Post.all
  # end

  # def show
  #   @comment = Comment.find(params[:id])
  # end

  # def new
  # 	if logged_in?
	 #    @comment = current_user.posts.build 
	 #  else
	 #  	redirect_to login_url
	 #  end	
  # end

  def create
  	@post = Post.find(session[:current_post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = session[:user_id]
    if @comment.save
      flash[:success] = "Post created!"
      redirect_to @post
    else
      @feed_items = []
				redirect_to @post	
	    end
  end

  def destroy
  	@post = Post.find(session[:current_post_id])
  	@comment = Comment.find(params[:id])
    @comment.destroy
    flash[:success] = "Post deleted"
    redirect_to @post
  end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def correct_user
      @post = Post.find(session[:current_post_id])
      @comment = @post.comments.find_by(id: params[:id])
      redirect_to @post if @comment.nil?
    end
end
