class PostsController < ApplicationController
  def index
    @posts = Post.order(id: :desc).page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params.expect(:id))
  end
end
