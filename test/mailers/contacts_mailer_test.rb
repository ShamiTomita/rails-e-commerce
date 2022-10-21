require "test_helper"

class ContactsMailerTest < ActionMailer::TestCase
  test "mailer" do
    mail = ContactsMailer.mailer
    assert_equal "Mailer", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
