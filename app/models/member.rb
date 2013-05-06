class Member < ActiveRecord::Base
  validates :full_name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true
end
