class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).limit(20)
  end

  def show
    @post = Post.find(params.expect(:id))
  end
end
