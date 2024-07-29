class YearsController < ApplicationController
  def show
    @year = params[:year]

    @posts = Post.where("STRFTIME('%Y', date) = ?", @year).order(:date)
  end
end
