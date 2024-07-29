class FeedsController < ApplicationController
  def show
    @posts = Post.order(date: :desc).limit(20)
  end
end
