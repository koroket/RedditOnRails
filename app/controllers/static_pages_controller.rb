class StaticPagesController < ApplicationController
  def home
    @posts = Post.all
  end

  def signup
  end

  def profile
  end

  def addpost
  end
end
