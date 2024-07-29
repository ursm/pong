class PostsController < ApplicationController
  def index
    @posts = Post.order(date: :desc).limit(20)
  end
end
