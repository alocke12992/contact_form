require 'test_helper'

class MessageTest < ActiveSupport::TestCase

  # previous test omitted

  test 'should be valid when all attributes are set' do
    attrs = { 
      name: 'stephen',
      email: 'stephen@example.org',
      body: 'kthnxbai'
    }

    msg = Message.new attrs
    assert msg.valid?, 'should be valid'
  end

  test 'name, email and body are required by law' do
    msg = Message.new

    refute msg.valid?, 'Blank Mesage should be invalid'

    assert_match /blank/, msg.errors[:name].to_s
    assert_match /blank/, msg.errors[:email].to_s
    assert_match /blank/, msg.errors[:body].to_s
  end

  test "POST create" do
    post create_message_url, params: {
      message: {
        name: 'cornholio',
        email: 'cornholio@example.org',
        body: 'hai'
      }
    }

    assert_redirected_to new_message_url

    follow_redirect!

    assert_match /Message received, thanks!/, response.body
  end
  
end