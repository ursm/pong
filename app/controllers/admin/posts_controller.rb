class Admin::PostsController < ApplicationController
  layout "admin"

  def index
    @posts = Post.order(date: :desc)
  end

  def new
    @post = Post.new(date: Date.current)
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])

    if @post.update(post_params)
      redirect_to admin_root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Post.find(params[:id]).destroy!

    redirect_to admin_root_path
  end

  def preview
    @post = Post.new(post_params)

    render layout: false
  end

  private

  def post_params
    params.require(:post).permit(:date, :body)
  end
end
