class DebugController < ApplicationController
  def write
    current = ActiveRecord::Base.connection.select_value("PRAGMA user_version")

    ActiveRecord::Base.connection.execute("PRAGMA user_version = #{current + 1}")

    head :ok
  end
end
