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
				redirect_to root_url	
	    end
  end

  # def destroy
  #   @post.destroy
  #   flash[:success] = "Post deleted"
  #   redirect_to request.referrer || root_url
  # end

  private

    def comment_params
      params.require(:comment).permit(:content)
    end
    
  #   def correct_user
  #     @post = current_user.posts.find_by(id: params[:id])
  #     redirect_to root_url if @post.nil?
  #   end
end
