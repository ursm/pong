class FeedsController < ApplicationController
  def show
    @posts = Post.order(id: :desc).limit(20)
  end
end
