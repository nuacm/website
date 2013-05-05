class Member < ActiveRecord::Base
  has_secure_password :validations => true
  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  has_one :reset_key # Or none. (Never more then one)

  # This method will create a new ResetKey for this member.
  # ResetKeys are valid for 1 day, and consist of a random 32 char
  # hex string.
  #
  def forgot_password!
    if self.reset_key
      self.reset_key.destroy
    end

    self.reset_key = ResetKey.create
  end

  def update_password(value, confimation, options = {})
    if options.key?(:key) && (reset_key.expired? || options[:key] != reset_key.key)
      raise "bad key"
    end

    update_attributes(:password => value, :password_confirmation => confimation)
  end
end
