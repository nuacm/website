class Member < ActiveRecord::Base
  has_secure_password :validations => true
  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true
end
