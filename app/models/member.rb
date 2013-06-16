class Member < ActiveRecord::Base
  has_secure_password

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  before_create { generate_unique_token(:auth_token) }

  # generate_unique_token : Symbol -> Member
  # Generates a unique token and sets it to the given attribute.
  #
  # Note: This method does NOT save the attribute to the member,
  # you must call #save afterward.
  def generate_unique_token(attribute)
    begin
      self[attribute] = SecureRandom.urlsafe_base64
    end while Member.exists?(attribute => self[attribute])
    self
  end

  # send_password_reset -> Mail::Message
  # Generates a fresh password reset token, and updates
  # the password reset at before sending an email to the
  # member with a link to reset his/her password.
  def send_password_reset
    generate_unique_token(:password_reset_token)
    self.password_reset_sent_at = DateTime.current
    save!
    MemberMailer.password_reset(self).deliver
  end
end
