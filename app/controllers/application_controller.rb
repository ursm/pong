class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  rescue_from ActiveRecord::StatementInvalid do |e|
    if e.message =~ /cannot rollback - no transaction is active/
      head :method_not_allowed
    else
      raise e
    end
  end
end
