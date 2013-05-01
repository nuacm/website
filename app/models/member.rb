class Member < ActiveRecord::Base
  has_secure_password
  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  has_one :reset_key # Or none. (Never more then one)

  def forgot_password!
    if self.reset_key
      self.reset_key.destroy
    end

    self.reset_key = ResetKey.create :valid_until => DateTime.current + 1.day
  end
end
