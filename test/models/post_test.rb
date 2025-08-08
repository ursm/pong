require 'test_helper'

class PostTest < ActiveSupport::TestCase
  test 'set attachments' do
    text = ActiveStorage::Blob.create_and_upload!(
      io:           StringIO.new(''),
      filename:     'empty.txt',
      content_type: 'text/plain'
    )

    image = ActiveStorage::Blob.create_and_upload!(
      io:           StringIO.new(''),
      filename:     'empty.jpg',
      content_type: 'image/jpeg'
    )

    post = Post.create!(
      title: 'Hello, world!',

      body: <<~MARKDOWN
        [Link](/rails/active_storage/blobs/proxy/#{text.signed_id}/empty.txt)
        ![Image](/rails/active_storage/blobs/proxy/#{image.signed_id}/empty.jpg)
      MARKDOWN
    )

    assert_equal [text, image].map(&:signed_id).sort, post.attachments.map(&:signed_id).sort
  end
end
