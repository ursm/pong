module LitefsAware
  extend ActiveSupport::Concern

  READONLY_METHODS = %w[GET HEAD OPTIONS].to_set.freeze

  SQLITE_RO_ERRORS = Regexp.union(
    'attempt to write a readonly database',
    'cannot rollback - no transaction is active'
  ).freeze

  included do
    before_action :reject_write_on_replica, if: -> { Rails.env.production? }

    rescue_from ActiveRecord::StatementInvalid do |e|
      raise e unless e.message.match?(SQLITE_RO_ERRORS)

      readonly_response
    end
  end

  private

  def reject_write_on_replica
    return if READONLY_METHODS.include?(request.method)
    return if Litefs.primary?

    readonly_response
  end

  def readonly_response
    headers["Allow"] = READONLY_METHODS.join(", ")

    head :method_not_allowed
  end
end
