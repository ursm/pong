class DebugController < ApplicationController
  skip_forgery_protection

  def write
    sleep 1

    current = ActiveRecord::Base.connection.select_value("PRAGMA user_version")
    ActiveRecord::Base.connection.execute "PRAGMA user_version = #{current + 1}"

    head :ok
  end
end
