class Member < ActiveRecord::Base

  validates :name, :presence => true
  validates :email, :presence => true, :uniqueness => true, :email => true

end
