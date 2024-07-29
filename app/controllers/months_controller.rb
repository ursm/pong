class MonthsController < ApplicationController
  def show
    @year, @month = params.values_at(:year_year, :month)

    @posts = Post.where("STRFTIME('%Y', date) = ? AND STRFTIME('%m', date) = ?", @year, @month).order(:date)
  end
end
