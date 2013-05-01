class Member < ActiveRecord::Base
  has_secure_password
  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

  has_one :reset_key # Or none. (Never more then one)
end
