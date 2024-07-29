class DaysController < ApplicationController
  def show
    @year, @month, @day = params.values_at(:year_year, :month_month, :day)

    @posts = Post.where("STRFTIME('%Y', date) = ? AND STRFTIME('%m', date) = ?", @year, @month).order(:date)
    @post  = @posts.where("STRFTIME('%d', date) = ?", @day).take!
  end
end
