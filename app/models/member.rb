class Member < ActiveRecord::Base
  has_secure_password
  validates_presence_of   :full_name
  validates_uniqueness_of :email
end
