class Member < ActiveRecord::Base
  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  before_create { create_authorization_key }
  after_create { subscribe_to("ACM Members") }
  after_destroy { unsubscribe_from("ACM Members") }

  has_one :authorization_key,
          -> { where :key_type => "authorization_key" },
          :class_name => "Key",
          :as         => :keyable,
          :dependent  => :destroy
  has_one :password_reset_key,
          -> { where :key_type => "password_reset_key" },
          :class_name => "Key",
          :as         => :keyable,
          :dependent  => :destroy

  # send_password_reset -> Mail::Message
  # Generates a fresh password reset token, and updates
  # the password reset at before sending an email to the
  # member with a link to reset his/her password.
  def send_password_reset
    create_password_reset_key(:expires_on => DateTime.current + 2.hours)
    MemberMailer.password_reset(self).deliver
  end

  # Mailchimp Integration.

  # subscribe_to String ->
  def subscribe_to(list_name)
    mailchimp = Mailchimp::API.new(NUACM::Application.config.mailchimp_api_key)
    list = mailchimp.lists.list['data'].find { |l| l['name'] == list_name }
    id = list['id']
    mailchimp.lists.subscribe id, { 'email' => self.email }
  end

  # unsubscribe_from String ->
  def unsubscribe_from(list_name)
    mailchimp = Mailchimp::API.new(NUACM::Application.config.mailchimp_api_key)
    list = mailchimp.lists.list['data'].find { |l| l['name'] == list_name }
    id = list['id']
    begin
      mailchimp.lists.unsubscribe id, { 'email' => self.email }
    rescue Mailchimp::EmailNotExistsError
    end
  end
end
