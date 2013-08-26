class SecureMember < Member
  has_secure_password

  before_create { create_authorization_key }

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

  def self.model_name
    Member.model_name
  end

end
