class Post < ApplicationRecord
  has_many_attached :attachments

  validates :date, presence: true, uniqueness: true
  validates :body, presence: true

  before_save :set_attachments
  after_commit :purge_unattached_blobs

  def rendered_body
    return "" unless body

    Commonmarker.to_html(body).html_safe
  end

  private

  def set_attachments
    signed_ids = []

    Commonmarker.parse(body).walk do |node|
      case node.type
      when :link, :image
        if %r{\A/rails/active_storage/blobs/(?:redirect/|proxy/)?(?<signed_id>\S+)/} =~ node.url
          signed_ids << signed_id
        end
      end
    end

    self.attachments = signed_ids
  end

  def purge_unattached_blobs
    ActiveStorage::Blob.unattached.each(&:purge)
  end
end
