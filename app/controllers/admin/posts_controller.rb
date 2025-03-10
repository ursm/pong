class Admin::PostsController < ApplicationController
  layout "admin"

  admin_auth = Rails.application.config_for(:admin_auth)

  if admin_auth.enabled
    http_basic_authenticate_with **admin_auth.slice(:name, :password)
  end

  def index
    @posts = Post.order(id: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      publish

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
      publish

      redirect_to admin_root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    Post.find(params.expect(:id)).destroy!

    redirect_to admin_root_path
  end

  def preview
    post = Post.new(post_params)

    render turbo_stream: turbo_stream.update("preview", partial: "posts/post", locals: { post: })
  end

  private

  def post_params
    params.expect(post: %i[title body])
  end

  def publish
    return unless Rails.application.config_for(:app).websub

    Fetch::API.fetch "https://pubsubhubbub.appspot.com/publish", **{
      method: "POST",

      body: Fetch::URLSearchParams.new(
        "hub.mode": "publish",
        "hub.url":  posts_url(format: :atom)
      )
    }
  end
end
