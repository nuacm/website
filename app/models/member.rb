class Member < ActiveRecord::Base
  has_secure_password
  validates_presence_of   :full_name
  validates :email, :presence => true, :uniqueness => true, :email => true
end
